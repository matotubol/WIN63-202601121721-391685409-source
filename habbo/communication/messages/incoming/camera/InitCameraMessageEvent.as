package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.InitCameraMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class InitCameraMessageEvent extends MessageEvent
   {
      
      public function InitCameraMessageEvent(param1:Function)
      {
         super(param1,InitCameraMessageEventParser);
      }
      
      public function getParser() : InitCameraMessageEventParser
      {
         return this.var_15 as InitCameraMessageEventParser;
      }
   }
}

