function figurePlotting(position,textStyle)
% figurePlotting(position,textStyle)
% 
% If there is no input to the function, it will just plot 
% an un-docked plot
%
% where
%   position = [posX_on_screen, ...
%               posY_on_screen, ...
%               width_of_figure, ... 
%               height_of_figure];
%
%   textStyle = 'Latex', if Latex style is wanted. 
%       (With no input, textStyle will not change)
%                
%



if nargin < 2
  textStyle = 'bum';
end
% if nargin < 2
%   fontSize = 0;
% end
if nargin < 1
  position = 0;
end


if position ~= 0
    figure('WindowStyle','normal','Position',[position(1) position(2) position(3) position(4)])
else
    figure('WindowStyle','normal')
end
    
if strcmp(textStyle,'Latex') || strcmp(textStyle,'latex') || strcmp(textStyle,'LATEX')
    set(0,'defaultTextInterpreter','latex')
end

% if fontSize > 0
%     set(gca, 'fontsize', fontSize)
% end

end

