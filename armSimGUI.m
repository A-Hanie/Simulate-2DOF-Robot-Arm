classdef armSimGUI < matlab.apps.AppBase


    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        LogsTextArea                  matlab.ui.control.TextArea
        LogsTextAreaLabel             matlab.ui.control.Label
        StateLamp                     matlab.ui.control.Lamp
        StateLampLabel                matlab.ui.control.Label
        Switch                        matlab.ui.control.Switch
        SimulateButton                matlab.ui.control.Button
        SimulationConfigurationPanel  matlab.ui.container.Panel
        NumofSampleEditField          matlab.ui.control.NumericEditField
        NumofSampleEditFieldLabel     matlab.ui.control.Label
        CircleConfigurationPanel      matlab.ui.container.Panel
        CircleradiusEditField         matlab.ui.control.NumericEditField
        CircleradiusEditFieldLabel    matlab.ui.control.Label
        CircleCenterxEditField        matlab.ui.control.NumericEditField
        CircleCenterxEditFieldLabel   matlab.ui.control.Label
        CircleCenteryEditField        matlab.ui.control.NumericEditField
        CircleCenteryEditFieldLabel   matlab.ui.control.Label
        ArmConfigurationPanel         matlab.ui.container.Panel
        Link2lengthEditField          matlab.ui.control.NumericEditField
        Link2lengthEditFieldLabel     matlab.ui.control.Label
        Link1lengthEditField          matlab.ui.control.NumericEditField
        Link1lengthEditFieldLabel     matlab.ui.control.Label
        UIAxesTheta2                  matlab.ui.control.UIAxes
        UIAxesTheta1                  matlab.ui.control.UIAxes
        UIAxes                        matlab.ui.control.UIAxes
    end


    methods (Access = private)


        function SimulateButtonPushed(app, event)
            armSim(app, event);
        end
    end


    methods (Access = private)


        function createComponents(app)


            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1103 562];
            app.UIFigure.Name = 'MATLAB App';


            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, '2 DOF arm Simulation')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.Box = 'on';
            app.UIAxes.Position = [269 104 444 431];


            app.UIAxesTheta1 = uiaxes(app.UIFigure);
            title(app.UIAxesTheta1, 'Theta 1 vs Time')
            xlabel(app.UIAxesTheta1, 'Time')
            ylabel(app.UIAxesTheta1, 'rad')
            zlabel(app.UIAxesTheta1, 'Z')
            app.UIAxesTheta1.XGrid = 'on';
            app.UIAxesTheta1.YGrid = 'on';
            app.UIAxesTheta1.Position = [751 325 323 210];


            app.UIAxesTheta2 = uiaxes(app.UIFigure);
            title(app.UIAxesTheta2, 'Theta 2 vs Time')
            xlabel(app.UIAxesTheta2, 'Time')
            ylabel(app.UIAxesTheta2, 'rad')
            zlabel(app.UIAxesTheta2, 'Z')
            app.UIAxesTheta2.XGrid = 'on';
            app.UIAxesTheta2.YGrid = 'on';
            app.UIAxesTheta2.Position = [750 104 324 202];


            app.ArmConfigurationPanel = uipanel(app.UIFigure);
            app.ArmConfigurationPanel.Title = 'Arm Configuration';
            app.ArmConfigurationPanel.Position = [37 409 185 118];


            app.Link1lengthEditFieldLabel = uilabel(app.ArmConfigurationPanel);
            app.Link1lengthEditFieldLabel.HorizontalAlignment = 'right';
            app.Link1lengthEditFieldLabel.Position = [15 54 73 22];
            app.Link1lengthEditFieldLabel.Text = 'Link 1 length';


            app.Link1lengthEditField = uieditfield(app.ArmConfigurationPanel, 'numeric');
            app.Link1lengthEditField.Limits = [0 Inf];
            app.Link1lengthEditField.Position = [102 54 68 22];
            app.Link1lengthEditField.Value = 3;


            app.Link2lengthEditFieldLabel = uilabel(app.ArmConfigurationPanel);
            app.Link2lengthEditFieldLabel.HorizontalAlignment = 'right';
            app.Link2lengthEditFieldLabel.Position = [15 13 73 22];
            app.Link2lengthEditFieldLabel.Text = 'Link 2 length';


            app.Link2lengthEditField = uieditfield(app.ArmConfigurationPanel, 'numeric');
            app.Link2lengthEditField.Limits = [0 Inf];
            app.Link2lengthEditField.Position = [102 13 68 22];
            app.Link2lengthEditField.Value = 4;


            app.CircleConfigurationPanel = uipanel(app.UIFigure);
            app.CircleConfigurationPanel.Title = 'Circle Configuration';
            app.CircleConfigurationPanel.Position = [37 226 185 163];


            app.CircleCenteryEditFieldLabel = uilabel(app.CircleConfigurationPanel);
            app.CircleCenteryEditFieldLabel.HorizontalAlignment = 'right';
            app.CircleCenteryEditFieldLabel.Position = [10 58 84 22];
            app.CircleCenteryEditFieldLabel.Text = 'Circle Center y';


            app.CircleCenteryEditField = uieditfield(app.CircleConfigurationPanel, 'numeric');
            app.CircleCenteryEditField.Limits = [0 Inf];
            app.CircleCenteryEditField.Position = [108 58 68 22];
            app.CircleCenteryEditField.Value = 2;


            app.CircleCenterxEditFieldLabel = uilabel(app.CircleConfigurationPanel);
            app.CircleCenterxEditFieldLabel.HorizontalAlignment = 'right';
            app.CircleCenterxEditFieldLabel.Position = [10 99 84 22];
            app.CircleCenterxEditFieldLabel.Text = 'Circle Center x';


            app.CircleCenterxEditField = uieditfield(app.CircleConfigurationPanel, 'numeric');
            app.CircleCenterxEditField.Limits = [0 Inf];
            app.CircleCenterxEditField.Position = [108 99 68 22];
            app.CircleCenterxEditField.Value = 3;


            app.CircleradiusEditFieldLabel = uilabel(app.CircleConfigurationPanel);
            app.CircleradiusEditFieldLabel.HorizontalAlignment = 'right';
            app.CircleradiusEditFieldLabel.Position = [16 18 72 22];
            app.CircleradiusEditFieldLabel.Text = 'Circle radius';


            app.CircleradiusEditField = uieditfield(app.CircleConfigurationPanel, 'numeric');
            app.CircleradiusEditField.Limits = [0 Inf];
            app.CircleradiusEditField.Position = [108 18 68 22];
            app.CircleradiusEditField.Value = 2;


            app.SimulationConfigurationPanel = uipanel(app.UIFigure);
            app.SimulationConfigurationPanel.Title = 'Simulation Configuration';
            app.SimulationConfigurationPanel.Position = [38 122 185 80];


            app.NumofSampleEditFieldLabel = uilabel(app.SimulationConfigurationPanel);
            app.NumofSampleEditFieldLabel.HorizontalAlignment = 'right';
            app.NumofSampleEditFieldLabel.Position = [4 16 88 22];
            app.NumofSampleEditFieldLabel.Text = 'Num of Sample';


            app.NumofSampleEditField = uieditfield(app.SimulationConfigurationPanel, 'numeric');
            app.NumofSampleEditField.Limits = [0 Inf];
            app.NumofSampleEditField.Position = [106 16 68 22];
            app.NumofSampleEditField.Value = 99;


            app.SimulateButton = uibutton(app.UIFigure, 'push');
            app.SimulateButton.ButtonPushedFcn = createCallbackFcn(app, @SimulateButtonPushed, true);
            app.SimulateButton.Position = [41 45 100 23];
            app.SimulateButton.Text = 'Simulate';


            app.Switch = uiswitch(app.UIFigure, 'slider');
            app.Switch.Position = [173 47 40 18];


            app.StateLampLabel = uilabel(app.UIFigure);
            app.StateLampLabel.HorizontalAlignment = 'right';
            app.StateLampLabel.Position = [305 45 33 22];
            app.StateLampLabel.Text = 'State';


            app.StateLamp = uilamp(app.UIFigure);
            app.StateLamp.Position = [353 45 20 20];
            app.StateLamp.Color = [1 1 0];


            app.LogsTextAreaLabel = uilabel(app.UIFigure);
            app.LogsTextAreaLabel.HorizontalAlignment = 'right';
            app.LogsTextAreaLabel.Position = [412 62 31 22];
            app.LogsTextAreaLabel.Text = 'Logs';


            app.LogsTextArea = uitextarea(app.UIFigure);
            app.LogsTextArea.Position = [458 26 215 60];


            app.UIFigure.Visible = 'on';
        end
    end


    methods (Access = public)


        function app = armSimGUI


            createComponents(app)


            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end


        function delete(app)


            delete(app.UIFigure)
        end
    end
end