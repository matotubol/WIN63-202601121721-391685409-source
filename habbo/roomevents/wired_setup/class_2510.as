package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public interface class_2510
   {
      
      function getElementByCode(param1:int) : class_2403;
      
      function getKey() : String;
      
      function acceptTriggerable(param1:class_2397) : Boolean;
   }
}

