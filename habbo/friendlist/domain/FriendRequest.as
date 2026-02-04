package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import package_14.class_2254;
   
   public class FriendRequest implements class_13
   {
      
      public static const STATE_OPEN:int = 1;
      
      public static const STATE_ACCEPTED:int = 2;
      
      public static const STATE_DECLINED:int = 3;
      
      public static const STATE_FAILED:int = 4;
      
      private var var_2563:int;
      
      private var _requesterName:String;
      
      private var var_4044:int;
      
      private var var_61:int = 1;
      
      private var _disposed:Boolean;
      
      private var var_18:class_1812;
      
      public function FriendRequest(param1:class_2254)
      {
         super();
         var_2563 = param1.requestId;
         _requesterName = param1.requesterName;
         var_4044 = param1.requesterUserId;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(view != null)
         {
            view.destroy();
            view = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get requestId() : int
      {
         return var_2563;
      }
      
      public function get requesterName() : String
      {
         return _requesterName;
      }
      
      public function get requesterUserId() : int
      {
         return var_4044;
      }
      
      public function get view() : class_1812
      {
         return var_18;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function set view(param1:class_1812) : void
      {
         var_18 = param1;
      }
      
      public function set state(param1:int) : void
      {
         var_61 = param1;
      }
   }
}

