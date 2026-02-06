package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_3464 implements class_13, class_2637
   {
      
      private var var_857:int;
      
      private var var_4724:String;
      
      private var _rooms:Array = [];
      
      private var var_1829:class_2460;
      
      private var _disposed:Boolean;
      
      public function class_3464(param1:IMessageDataWrapper)
      {
         super();
         var_857 = param1.readInteger();
         var_4724 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _rooms.push(new class_1945(param1));
            _loc3_++;
         }
         var _loc4_:Boolean = param1.readBoolean();
         if(_loc4_)
         {
            var_1829 = new class_2460(param1);
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(this._rooms != null)
         {
            for each(var _loc1_ in this._rooms)
            {
               _loc1_.dispose();
            }
         }
         if(var_1829 != null)
         {
            var_1829.dispose();
            var_1829 = null;
         }
         this._rooms = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get searchType() : int
      {
         return var_857;
      }
      
      public function get searchParam() : String
      {
         return var_4724;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
      
      public function get ad() : class_2460
      {
         return var_1829;
      }
   }
}

