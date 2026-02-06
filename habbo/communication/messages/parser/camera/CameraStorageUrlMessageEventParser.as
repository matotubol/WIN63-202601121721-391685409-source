package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraStorageUrlMessageEventParser implements IMessageParser
   {
      
      private var var_989:String;
      
      public function CameraStorageUrlMessageEventParser()
      {
         super();
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function flush() : Boolean
      {
         var_989 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_989 = param1.readString();
         return true;
      }
   }
}

