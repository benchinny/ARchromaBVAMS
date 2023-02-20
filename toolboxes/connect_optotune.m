function scene = connect_optotune_1(scene)
    global log
    
    cmsg('Enabling Optotune', log.INFO, log.LEVEL);
    list_of_devices = seriallist;
    for i = 1:length(list_of_devices)
        if length(regexp(list_of_devices(i), 'COM4')) > 0
            scene.opto1 = Optotune(list_of_devices(i));
            scene.opto1.Open();
        end
    end
end