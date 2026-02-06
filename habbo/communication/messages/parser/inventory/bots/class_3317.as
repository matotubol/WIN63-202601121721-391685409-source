package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3317
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_3144:String;
      
      private var var_111:String;
      
      private var var_975:String;
      
      public function class_3317(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readInteger();
         _name = param1.readString();
         var_3144 = param1.readString();
         var_111 = param1.readString();
         var_975 = param1.readString();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
   }
}

