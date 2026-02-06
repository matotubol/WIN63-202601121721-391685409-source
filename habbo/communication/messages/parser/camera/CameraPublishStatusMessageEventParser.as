package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraPublishStatusMessageEventParser implements IMessageParser
   {
      
      private var var_2577:Boolean = false;
      
      private var var_3341:int = 0;
      
      private var var_2842:String;
      
      public function CameraPublishStatusMessageEventParser()
      {
         super();
      }
      
      public function isOk() : Boolean
      {
         return var_2577;
      }
      
      public function getSecondsToWait() : int
      {
         return var_3341;
      }
      
      public function getExtraDataId() : String
      {
         return var_2842;
      }
      
      public function flush() : Boolean
      {
         var_2577 = false;
         var_3341 = 0;
         var_2842 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2577 = param1.readBoolean();
         var_3341 = param1.readInteger();
         if(var_2577 && param1.bytesAvailable)
         {
            var_2842 = param1.readString();
         }
         return true;
      }
   }
}

