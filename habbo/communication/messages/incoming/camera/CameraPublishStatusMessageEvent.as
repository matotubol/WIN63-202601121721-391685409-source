package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.CameraPublishStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CameraPublishStatusMessageEvent extends MessageEvent
   {
      
      public function CameraPublishStatusMessageEvent(param1:Function)
      {
         super(param1,CameraPublishStatusMessageEventParser);
      }
      
      public function getParser() : CameraPublishStatusMessageEventParser
      {
         return this.var_15 as CameraPublishStatusMessageEventParser;
      }
   }
}

