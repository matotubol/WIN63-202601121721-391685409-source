package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_2460 implements class_13
   {
      
      public static const const_237:int = 1;
      
      public static const const_235:int = 2;
      
      public static const const_398:int = 4;
      
      private var _index:int;
      
      private var var_4434:String;
      
      private var var_5118:String;
      
      private var var_5096:Boolean;
      
      private var var_4442:String;
      
      private var var_2063:String;
      
      private var var_4729:int;
      
      private var var_3244:int;
      
      private var var_230:int;
      
      private var var_3795:String;
      
      private var var_58:class_1945;
      
      private var _open:Boolean;
      
      private var _disposed:Boolean;
      
      public function class_2460(param1:IMessageDataWrapper)
      {
         super();
         _index = param1.readInteger();
         var_4434 = param1.readString();
         var_5118 = param1.readString();
         var_5096 = param1.readInteger() == 1;
         var_4442 = param1.readString();
         var_2063 = param1.readString();
         var_4729 = param1.readInteger();
         var_3244 = param1.readInteger();
         var_230 = param1.readInteger();
         if(var_230 == 1)
         {
            var_3795 = param1.readString();
         }
         else if(var_230 == 2)
         {
            var_58 = new class_1945(param1);
         }
         else
         {
            _open = param1.readBoolean();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(this.var_58 != null)
         {
            this.var_58.dispose();
            this.var_58 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get popupCaption() : String
      {
         return var_4434;
      }
      
      public function get popupDesc() : String
      {
         return var_5118;
      }
      
      public function get showDetails() : Boolean
      {
         return var_5096;
      }
      
      public function get picText() : String
      {
         return var_4442;
      }
      
      public function get picRef() : String
      {
         return var_2063;
      }
      
      public function get folderId() : int
      {
         return var_4729;
      }
      
      public function get tag() : String
      {
         return var_3795;
      }
      
      public function get userCount() : int
      {
         return var_3244;
      }
      
      public function get guestRoomData() : class_1945
      {
         return var_58;
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function toggleOpen() : void
      {
         _open = !_open;
      }
      
      public function get maxUsers() : int
      {
         if(this.type == 1)
         {
            return 0;
         }
         if(this.type == 2)
         {
            return this.var_58.maxUserCount;
         }
         return 0;
      }
   }
}

