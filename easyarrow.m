function [] = easyarrow(x1, x2, y1, y2, varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    
    addRequired(p, 'x1', @isnumeric)
    addRequired(p, 'x2', @isnumeric)
    addRequired(p, 'y1', @isnumeric)
    addRequired(p, 'y2', @isnumeric)
    addOptional(p, 'z1', NaN, @isnumeric)
    addOptional(p, 'z2', NaN, @isnumeric)
    
    addParameter(p, 'solid', 0)
    
    parse(p, x1, x2, y1, y2, varargin{:});
    
    ip = p.Results;
    
    axis equal;
    
    %% Preparation
    % Z Vector
    if(isnan(ip.z2))
        if(~isnan(ip.z1))
            % If only one Z vector is given, assume that the Z values vor
            % the endpoint are equal to the start point's
            ip.z2 = ip.z1;
        % Check vector dimensions
            if(~isequal(size(ip.x1), size(ip.x2), size(ip.y1), size(ip.y2), size(ip.z1), size(ip.z2)))
                error('Input dimension mismatch. All vectors must be of equal length!')
            end
        else
            if(~isequal(size(ip.x1), size(ip.x2), size(ip.y1), size(ip.y2)))
                error('Input dimension mismatch. All vectors must be of equal length!')
            end
        end
    end
    
    oldhold = ishold;
    hold on;
    
    alpha = 0.3;
    beta = 0.1;
    
    %% 2D arrow
    if(isnan(ip.z1))
        plot([ip.x1; ip.x2], [ip.y1; ip.y2], 'k') % Plot stem of arrow

        % Calculate the arrowhead
        x = ip.x2 - ip.x1;
        y = ip.y2 - ip.y1;
        
        u = [ip.x2-alpha*(x+beta*y); ip.x2; ip.x2-alpha*(x-beta*y)];
        v = [ip.y2-alpha*(y-beta*x); ip.y2; ip.y2-alpha*(y+beta*x)];
        
        if(ip.solid)
            fill(u, v, 'k') % plot arrowhead as solid patch
        else
            plot(u, v, 'k') % plot arrowhead as lines
        end

    end
    %% 3D arrow
    if(~isnan(ip.z1))
        plot3([ip.x1; ip.x2], [ip.y1; ip.y2], [ip.z1; ip.z2], 'k') % Plot stem of arrow

        % Calculate the arrowhead
        x = ip.x2 - ip.x1;
        y = ip.y2 - ip.y1;
        z = ip.z2 - ip.z1;
        
        u = [ip.x2-alpha*(x+beta*y); ip.x2; ip.x2-alpha*(x-beta*y)];
        v = [ip.y2-alpha*(y-beta*x); ip.y2; ip.y2-alpha*(y+beta*x)];
        w = [ip.z2-alpha*(z); ip.z2; ip.z2-alpha*(z)];
        
        if(ip.solid)
            fill3(u, v, w, 'k') % plot arrowhead as solid patch
        else
            plot3(u, v, w, 'k') % plot arrowhead as lines
        end
        
        
    end
    
    %% Finish
    % Return to old hold state
        if(~oldhold)
            hold off
        end
    
    
    
    


end

