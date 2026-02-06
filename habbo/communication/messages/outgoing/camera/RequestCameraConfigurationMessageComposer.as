package com.sulake.habbo.communication.messages.outgoing.camera
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RequestCameraConfigurationMessageComposer implements IMessageComposer
   {
      
      public function RequestCameraConfigurationMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
   }
}

