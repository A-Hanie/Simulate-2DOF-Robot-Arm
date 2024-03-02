 function armSim(app, event)

    hold(app.UIAxes, 'off');cla(app.UIAxes);
    hold(app.UIAxesTheta1, 'off');cla(app.UIAxesTheta1);
    hold(app.UIAxesTheta2, 'off');cla(app.UIAxesTheta2);

    % Link Configuration
    l1 = app.Link1lengthEditField.Value;
    l2 = app.Link2lengthEditField.Value;

    % Circle Configuration
    radius = app.CircleradiusEditField.Value;
    center_x = app.CircleCenterxEditField.Value;
    center_y = app.CircleCenteryEditField.Value;
    
    % Simulation Configuration
    num_points = app.NumofSampleEditField.Value;
    
    % graph Configuration
    axisLimit= l1+l2+5;
    
    theta_circle = linspace(0, 2*pi, num_points);
    
    % Circle points in Cartesian
    circle_x = center_x + radius * cos(theta_circle);
    circle_y = center_y + radius * sin(theta_circle);
    
    theta1_values = zeros(1, num_points);
    theta2_values = zeros(1, num_points);
    
    
    % Inv Kinematics (Calculate thetas for two links from x, y)
    for i = 1:num_points
    
        xd = circle_x(i);
        yd = circle_y(i);
        
        D = (xd^2 + yd^2 - l1^2 - l2^2) / (2 * l1 * l2);

        try 
            theta2 = atan2(sqrt(1 - D^2), D);
            theta1 = atan2(yd, xd) - atan2(l2 * sin(theta2), l1 + l2 * cos(theta2));
        catch

            % print in console
            app.LogsTextArea.Value = sprintf('[Error] Unreachable area!!\nThe Arm cannot reach the point (%0.1f, %0.1f)', xd, yd);
            
            
            % Enable red lamp
            app.StateLamp.Enable = "on";
            app.StateLamp.Color = [1, 0, 0];

            % return from function
            return ;
           
        end
        
        theta1_values(i) = theta1;
        theta2_values(i) = theta2;
    end
                
    % Axis limits of arm graph
    xlim(app.UIAxes,[-axisLimit, axisLimit]);
    ylim(app.UIAxes,[-axisLimit, axisLimit]);
    axis(app.UIAxes, 'equal')

    % Axis limits of theta 1 graph
    xlim(app.UIAxesTheta1,[0, num_points]);
    ylim(app.UIAxesTheta1,[min(theta1_values)-0.25, max(theta1_values)+0.25]);

    % Axis limits of theta 2 graph
    xlim(app.UIAxesTheta2,[0, num_points]);
    ylim(app.UIAxesTheta2,[min(theta2_values)-0.25, max(theta2_values)+0.25]);

    hold(app.UIAxes, 'on');
    hold(app.UIAxesTheta1, 'on');
    hold(app.UIAxesTheta2, 'on');   
   
    % Enable green lamp
    app.StateLamp.Enable = "on";
    app.StateLamp.Color = [0, 1, 0];    

    % Lock edit field 
    app.Link1lengthEditField.Editable ="off";
    app.Link2lengthEditField.Editable ="off";
    app.CircleCenterxEditField.Editable ="off";
    app.CircleCenteryEditField.Editable ="off";
    app.CircleradiusEditField.Editable ="off";
    app.NumofSampleEditField.Editable ="off";

    % print in console
    app.LogsTextArea.Value = sprintf('[INFO] Sumulation is Running!!'); 

    while ( "On" == app.Switch.Value )



        for t = 1:num_points

            if ("On" ~= app.Switch.Value)
                break;
            end

            % get Thetas for current time
            theta1 = theta1_values(t);
            theta2 = theta2_values(t);

            % Calc first link coordinates
            xl1 = l1 * cos(theta1);
            yl1 = l1 * sin(theta1);

            % Calc second link coordinates
            xl2 = xl1 + l2 * cos(theta1 + theta2);
            yl2 = yl1 + l2 * sin(theta1 + theta2);
            
            xlim(app.UIAxes,[-axisLimit, axisLimit]);
            ylim(app.UIAxes,[-axisLimit, axisLimit]); 

            % First link
            plot(app.UIAxes,[0, xl1], [0, yl1], 'color', 'black', 'LineWidth', 2.5);
            
            % Second link
            plot(app.UIAxes, [xl1, xl2], [yl1, yl2], 'color', 'blue', ...
                'LineWidth', 2.5);
        
            % Circle
            plot(app.UIAxes, circle_x, circle_y, '--', 'color', 'red', ...
                'LineWidth', 1);
        
            % End effector marker
            plot(app.UIAxes, xl2, yl2, 'o', 'MarkerSize', 4, 'MarkerFaceColor', ...
                'r', 'MarkerEdgeColor', 'k');

            % Circle center marker
            plot(app.UIAxes, center_x, center_y, 'x', 'MarkerSize', 8, ...
                'MarkerEdgeColor', 'k');
        
            % Plot theta 1
            plot(app.UIAxesTheta1, 1:t, theta1_values(1:t), 'color','k','LineWidth', 1);


            % Plot theta 2
            plot(app.UIAxesTheta2, 1:t, theta2_values(1:t),'color','b', 'LineWidth', 1);


            pause(0.02);
            cla(app.UIAxes);
            cla(app.UIAxesTheta1);
            cla(app.UIAxesTheta2);

        end
    end

    % Unlock edit field 
    app.Link1lengthEditField.Editable ="on";
    app.Link2lengthEditField.Editable ="on";
    app.CircleCenterxEditField.Editable ="on";
    app.CircleCenteryEditField.Editable ="on";
    app.CircleradiusEditField.Editable ="on";
    app.NumofSampleEditField.Editable ="on";

    % print in console
    app.LogsTextArea.Value = sprintf('[INFO] Sumulation is stopped!!');

    % Enable yellow lamp
    app.StateLamp.Enable = "on";
    app.StateLamp.Color = [1, 1, 0];
 end
