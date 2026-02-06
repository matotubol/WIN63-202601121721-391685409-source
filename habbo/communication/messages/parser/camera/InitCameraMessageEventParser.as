package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InitCameraMessageEventParser implements IMessageParser
   {
      
      private var var_3230:int = 0;
      
      private var var_3273:int = 0;
      
      private var var_3114:int = 0;
      
      public function InitCameraMessageEventParser()
      {
         super();
      }
      
      public function getCreditPrice() : int
      {
         return var_3230;
      }
      
      public function getDucketPrice() : int
      {
         return var_3273;
      }
      
      public function getPublishDucketPrice() : int
      {
         return var_3114;
      }
      
      public function flush() : Boolean
      {
         var_3230 = 0;
         var_3273 = 0;
         var_3114 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3230 = param1.readInteger();
         var_3273 = param1.readInteger();
         if(param1.bytesAvailable > 0)
         {
            var_3114 = param1.readInteger();
         }
         return true;
      }
   }
}

