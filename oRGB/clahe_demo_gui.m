function varargout = clahe_demo_gui(im)
    % load source image (demo works on both grayscale and color images)
    if nargin < 1
        %im = fullfile(mexopencv.root(),'test','tsukuba_l.png');
        im = fullfile(mexopencv.root(),'test','tsukuba.png');
        img = imread(im);
    elseif ischar(im)
        img = imread(im);
    else
        img = im;
    end

    % create the UI
    h = buildGUI(img);
    if nargout > 0, varargout{1} = h; end
end

function onChange(~,~,h)
    %ONCHANGE  Event handler for UI controls

    % retrieve current values from UI controls
    alg = get(h.pop, 'Value');
    clipLimit = get(h.slid(1), 'Value');
    tileSize = round(get(h.slid(2), 'Value'));
    set(h.txt(1), 'String',sprintf('Clip Limit: %.2f',clipLimit));
    set(h.txt(2), 'String',sprintf('Tile Size: %dx%d',tileSize,tileSize));

    % histogram equalization
    opts = {'ClipLimit',clipLimit, 'TileGridSize',[tileSize tileSize]};
    if alg == 3
        out = h.src;
    elseif size(h.src, 3) == 1
        % apply directly on grayscale image
        if alg == 1
            out = cv.CLAHE(h.src, opts{:});
        elseif alg == 2
            out = cv.equalizeHist(h.src);
        end
    else
        % convert to Lab colorspace, apply on L-channel, convert back to RGB
        lab = cv.cvtColor(h.src, 'RGB2Lab');
        if alg == 1
            lab(:,:,1) = cv.CLAHE(lab(:,:,1), opts{:});
        elseif alg == 2
            lab(:,:,1) = cv.equalizeHist(lab(:,:,1));
        end
        out = cv.cvtColor(lab, 'Lab2RGB');
    end

    % show result
    set(h.img, 'CData',out);
    drawnow;
end

function h = buildGUI(img)
    %BUILDGUI  Creates the UI

    % parameters
    clipLimit = 2.0;
    tileSize = 8;
    sz = size(img);
    sz(2) = max(sz(2), 300);  % minimum figure width

    % build the user interface (no resizing to keep it simple)
    h = struct();
    h.src = img;
    h.fig = figure('Name','CLAHE Demo', ...
        'NumberTitle','off', 'Menubar','none', 'Resize','off', ...
        'Position',[200 200 sz(2) sz(1)+80-1]);
    if ~mexopencv.isOctave()
        %HACK: not implemented in Octave
        movegui(h.fig, 'center');
    end
    h.ax = axes('Parent',h.fig, 'Units','pixels', 'Position',[1 80 sz(2) sz(1)]);
    if ~mexopencv.isOctave()
        h.img = imshow(img, 'Parent',h.ax);
    else
        %HACK: https://savannah.gnu.org/bugs/index.php?45473
        axes(h.ax);
        h.img = imshow(img);
    end
    h.txt(1) = uicontrol('Parent',h.fig, 'Style','text', 'FontSize',11, ...
        'Position',[5 5 130 20], 'String','Clip Limit:');
    h.txt(2) = uicontrol('Parent',h.fig, 'Style','text', 'FontSize',11, ...
        'Position',[5 30 130 20], 'String','Tile Size:');
    h.txt(3) = uicontrol('Parent',h.fig, 'Style','text', 'FontSize',11, ...
        'Position',[5 55 130 20], 'String','Algorithm:');
    h.slid(1) = uicontrol('Parent',h.fig, 'Style','slider', ...
        'Value',clipLimit, 'Min',0, 'Max',40, 'SliderStep',[0.1 2]./(40-0), ...
        'Position',[135 5 sz(2)-135-5 20]);
    h.slid(2) = uicontrol('Parent',h.fig, 'Style','slider', ...
        'Value',tileSize, 'Min',1, 'Max',32, 'SliderStep',[1 5]./(32-1), ...
        'Position',[135 30 sz(2)-135-5 20]);
    h.pop = uicontrol('Parent',h.fig, 'Style','popupmenu', ...
        'Position',[135 55 100 20], 'String',{'CLAHE','equalizeHist','-None-'});

    % hook event handlers, and trigger default start
    set([h.slid, h.pop], 'Callback',{@onChange,h}, ...
        'Interruptible','off', 'BusyAction','cancel');
    onChange([],[],h);
end