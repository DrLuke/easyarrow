function [] = easyarrow(x1, x2, y1, y2, varargin)
%UNTITLED2 Summary of this function goes here
%   
%   Quick Examples:
%   easyarrow([0], [1], [0], [1])
%   easyarrow([0 30], [20 50], [10 10], [30 30], [0 10], [10 -20], 'absolutelength', 10, 'solid', 1)
%   
%
    %% Input Parsing
    p = inputParser;
    
    addRequired(p, 'x1', @isnumeric)
    addRequired(p, 'x2', @isnumeric)
    addRequired(p, 'y1', @isnumeric)
    addRequired(p, 'y2', @isnumeric)
    addOptional(p, 'z1', NaN, @isnumeric)
    addOptional(p, 'z2', NaN, @isnumeric)
    
    addParameter(p, 'solid', 0, @isnumeric)
    addParameter(p, 'absolutelength', 0, @isnumeric)
    addParameter(p, 'headlength', 0.3, @isnumeric)
    addParameter(p, 'headwidth', 0.2, @isnumeric)
    addParameter(p, 'stemstyle', 'k', @isstring)
    addParameter(p, 'headstyle', 'k', @isstring)
    
    parse(p, x1, x2, y1, y2, varargin{:});
    
    ip = p.Results;
    
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
    
    % Used to restore hold state before function call
    oldhold = ishold;
    hold on;
    
    %% 2D arrow
    if(isnan(ip.z1))
        plot([ip.x1; ip.x2], [ip.y1; ip.y2], ip.stemstyle) % Plot stem of arrow

        % Calculate the arrowhead
        x = ip.x2 - ip.x1;
        y = ip.y2 - ip.y1;
        
        u = [ip.x2-ip.headlength*(x+ip.headwidth*y); ip.x2; ip.x2-ip.headlength*(x-ip.headwidth*y)];
        v = [ip.y2-ip.headlength*(y-ip.headwidth*x); ip.y2; ip.y2-ip.headlength*(y+ip.headwidth*x)];
        
        if(ip.solid)
            fill(u, v, ip.headstyle) % plot arrowhead as solid patch
        else
            plot(u, v, ip.headstyle) % plot arrowhead as lines
        end

    end
    %% 3D arrow
    if(~isnan(ip.z1))
        plot3([ip.x1; ip.x2], [ip.y1; ip.y2], [ip.z1; ip.z2], ip.stemstyle) % Plot stem of arrow

        % Calculate the arrowhead
        x = ip.x2 - ip.x1;
        y = ip.y2 - ip.y1;
        z = ip.z2 - ip.z1;
        
        if(~ip.absolutelength <= 0)
            ip.headlength = 1;
            vecnorm = sqrt(x.^2 + y.^2 + z.^2);
            x = (x./vecnorm) .* ip.absolutelength;
            y = (y./vecnorm) .* ip.absolutelength;
            z = (z./vecnorm) .* ip.absolutelength;
        end
        
        u = [ip.x2-ip.headlength*(x+ip.headwidth*y); ip.x2; ip.x2-ip.headlength*(x-ip.headwidth*y)];
        v = [ip.y2-ip.headlength*(y-ip.headwidth*x); ip.y2; ip.y2-ip.headlength*(y+ip.headwidth*x)];
        w = [ip.z2-ip.headlength*z; ip.z2; ip.z2-ip.headlength*z];
        
        if(ip.solid)
            fill3(u, v, w, ip.headstyle) % plot arrowhead as solid patch
        else
            plot3(u, v, w, ip.headstyle) % plot arrowhead as lines
        end
    end
    
    %% Finish
    % Return to old hold state
    if(~oldhold)
        hold off
    end
end

