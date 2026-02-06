package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2408
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      public function class_2408(param1:IMessageDataWrapper)
      {
         super();
         this.var_197 = param1.readInteger();
         this._name = param1.readString();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

