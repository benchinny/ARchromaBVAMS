  %close optotune
a = instrfind();
        if ~isempty(a) %isempty(Obj) returns logical 1 (true) if Obj is an empty ExptData object. Otherwise, it returns logical 0 (false). An empty ExptData object contains no data elements.
           fclose(a);
           delete(a);
           clear a;
        end
        
for p = 1:6
    try
        opto(p).control.Close();
        %opto(p).control.Delete();

    catch
    end
end

   portName = 'COM3'; 

   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;


   portName = 'COM4'; 

   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;


   portName = 'COM5'; 

   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;
   
      portName = 'COM6'; 

   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;

         portName = 'COM7'; 

   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;
   
            portName = 'COM8'; 

   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;

   portName = 'COM9'; 

   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;
   instrfind();