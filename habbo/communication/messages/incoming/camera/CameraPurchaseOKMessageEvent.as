package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.CameraPurchaseOKMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CameraPurchaseOKMessageEvent extends MessageEvent
   {
      
      public function CameraPurchaseOKMessageEvent(param1:Function)
      {
         super(param1,CameraPurchaseOKMessageEventParser);
      }
      
      public function getParser() : CameraPurchaseOKMessageEventParser
      {
         return this.var_15 as CameraPurchaseOKMessageEventParser;
      }
   }
}

