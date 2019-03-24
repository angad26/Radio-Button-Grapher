classdef RadioButtonGraph_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        PeaksButton            matlab.ui.control.Button
        RandomButton           matlab.ui.control.Button
        UIAxes                 matlab.ui.control.UIAxes
        SelecttypeButtonGroup  matlab.ui.container.ButtonGroup
        SurfButton             matlab.ui.control.RadioButton
        MeshButton             matlab.ui.control.RadioButton
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PeaksButton
        function PeaksButtonPushed(app, event)
            z=peaks;
            if get(app.SurfButton,'value')==1
                surf(app.UIAxes,z)
       
            else
                mesh(app.UIAxes,z)
            end
        end

        % Button pushed function: RandomButton
        function RandomButtonPushed(app, event)
            z=randi(49,49);
            if get(app.SurfButton,'value')==1
                surf(app.UIAxes,z)
            else
                mesh(app.UIAxes,z)
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 713 477];
            app.UIFigure.Name = 'UI Figure';

            % Create PeaksButton
            app.PeaksButton = uibutton(app.UIFigure, 'push');
            app.PeaksButton.ButtonPushedFcn = createCallbackFcn(app, @PeaksButtonPushed, true);
            app.PeaksButton.Position = [577 104 100 22];
            app.PeaksButton.Text = 'Peaks';

            % Create RandomButton
            app.RandomButton = uibutton(app.UIFigure, 'push');
            app.RandomButton.ButtonPushedFcn = createCallbackFcn(app, @RandomButtonPushed, true);
            app.RandomButton.Position = [577 68 100 22];
            app.RandomButton.Text = 'Random';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Graph')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.BackgroundColor = [1 1 1];
            app.UIAxes.Position = [1 35 548 408];

            % Create SelecttypeButtonGroup
            app.SelecttypeButtonGroup = uibuttongroup(app.UIFigure);
            app.SelecttypeButtonGroup.Title = ' Select type;';
            app.SelecttypeButtonGroup.Position = [565 186 123 106];

            % Create SurfButton
            app.SurfButton = uiradiobutton(app.SelecttypeButtonGroup);
            app.SurfButton.Text = 'Surf';
            app.SurfButton.Position = [11 60 44 22];
            app.SurfButton.Value = true;

            % Create MeshButton
            app.MeshButton = uiradiobutton(app.SelecttypeButtonGroup);
            app.MeshButton.Text = 'Mesh';
            app.MeshButton.Position = [11 42 52 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = RadioButtonGraph_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end