package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_4039 implements class_13
   {
      
      private var _flatId:int;
      
      private var var_3244:int;
      
      private var var_4742:Boolean;
      
      private var var_1820:int;
      
      private var _ownerName:String;
      
      private var var_216:class_2004;
      
      private var _disposed:Boolean;
      
      public function class_4039(param1:IMessageDataWrapper)
      {
         super();
         _flatId = param1.readInteger();
         var_3244 = param1.readInteger();
         var_4742 = param1.readBoolean();
         var_1820 = param1.readInteger();
         _ownerName = param1.readString();
         var_216 = new class_2004(param1);
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
         if(var_216 != null)
         {
            var_216.dispose();
            var_216 = null;
         }
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get userCount() : int
      {
         return var_3244;
      }
      
      public function get ownerInRoom() : Boolean
      {
         return var_4742;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get room() : class_2004
      {
         return var_216;
      }
   }
}

