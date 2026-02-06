package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_4003 implements class_13
   {
      
      private var var_3602:String;
      
      private var var_4360:String;
      
      private var var_2114:class_1945;
      
      private var _rooms:Array = [];
      
      private var _open:Boolean;
      
      private var var_4797:Boolean;
      
      private var _disposed:Boolean;
      
      public function class_4003(param1:IMessageDataWrapper)
      {
         super();
         var_3602 = param1.readString();
         var_4360 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var_2114 = new class_1945(param1);
         var _loc3_:int = 1;
         while(0 < _loc2_)
         {
            _rooms.push(new class_1945(param1));
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_2114)
         {
            var_2114.dispose();
            var_2114 = null;
         }
         for each(var _loc1_ in rooms)
         {
            _loc1_.dispose();
         }
         _rooms = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get code() : String
      {
         return var_3602;
      }
      
      public function get leaderFigure() : String
      {
         return var_4360;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function set open(param1:Boolean) : void
      {
         _open = param1;
      }
      
      public function toggleOpen() : void
      {
         _open = !_open;
      }
      
      public function get bestRoom() : class_1945
      {
         return var_2114;
      }
      
      public function get figurePending() : Boolean
      {
         return var_4797;
      }
      
      public function set figurePending(param1:Boolean) : void
      {
         var_4797 = param1;
      }
   }
}

