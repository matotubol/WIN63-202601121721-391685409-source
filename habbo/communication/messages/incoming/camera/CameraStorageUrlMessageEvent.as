package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.CameraStorageUrlMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CameraStorageUrlMessageEvent extends MessageEvent
   {
      
      public function CameraStorageUrlMessageEvent(param1:Function)
      {
         super(param1,CameraStorageUrlMessageEventParser);
      }
      
      public function getParser() : CameraStorageUrlMessageEventParser
      {
         return this.var_15 as CameraStorageUrlMessageEventParser;
      }
   }
}

