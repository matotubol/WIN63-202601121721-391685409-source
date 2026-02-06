package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ThumbnailStatusMessageEventParser implements IMessageParser
   {
      
      private var var_2577:Boolean = true;
      
      private var var_2929:Boolean = false;
      
      public function ThumbnailStatusMessageEventParser()
      {
         super();
      }
      
      public function isOk() : Boolean
      {
         return var_2577;
      }
      
      public function isRenderLimitHit() : Boolean
      {
         return var_2929;
      }
      
      public function flush() : Boolean
      {
         var_2577 = true;
         var_2929 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1.bytesAvailable)
         {
            var_2577 = param1.readBoolean();
            var_2929 = param1.readBoolean();
         }
         return true;
      }
   }
}

