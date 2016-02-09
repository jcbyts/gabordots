function screenInfo=getScreen(rig)

if ~exist('rig', 'var') || isempty(rig)
    rig='nhb';
end

switch rig
    case 'nhb'
        screenInfo.ppd=35.37;
        screenInfo.Fr=60;
    case 'Shadlen'
        % Shadlen rig ppd calculations based on Gold and Shadlen 2003
        % 21 inch monitor
        % 60 cm view dist
        % 1024 x 768 resolution
        % 75 Hz
        
        % 21 inch diagonal monitor has width of
        width=sqrt(21^2*16/25); % from pythagoras
        widthcm=width*2.54;
        degrees=atand(widthcm/2/60)*2;
        screenInfo.ppd=1024/degrees;
        screenInfo.Fr=75;
end
        
        
        
        
