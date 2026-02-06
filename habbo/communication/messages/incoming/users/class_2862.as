package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2862
   {
      
      private var var_197:int;
      
      private var _fileName:String;
      
      private var _maskFileName:String;
      
      public function class_2862(param1:IMessageDataWrapper = null)
      {
         super();
         var_197 = param1.readInteger();
         _fileName = param1.readString();
         _maskFileName = param1.readString();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get fileName() : String
      {
         return _fileName;
      }
      
      public function get maskFileName() : String
      {
         return _maskFileName;
      }
   }
}

