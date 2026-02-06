package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_2004 implements class_13
   {
      
      private var var_4589:Boolean;
      
      private var _name:String;
      
      private var _desc:String;
      
      private var var_553:Array = [];
      
      private var _disposed:Boolean;
      
      public function class_2004(param1:IMessageDataWrapper)
      {
         super();
         var_4589 = param1.readBoolean();
         if(!exists)
         {
            return;
         }
         _name = param1.readString();
         _desc = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_553.push(param1.readString());
            _loc3_++;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_553 = null;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function get tags() : Array
      {
         return var_553;
      }
      
      public function get exists() : Boolean
      {
         return var_4589;
      }
   }
}

