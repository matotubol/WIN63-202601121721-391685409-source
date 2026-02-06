package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_2842 implements class_13
   {
      
      private var var_5156:int;
      
      private var var_4599:int;
      
      private var var_3967:String;
      
      private var _flatId:int;
      
      private var var_2851:int;
      
      private var var_4220:int;
      
      private var var_4104:String;
      
      private var var_3890:String;
      
      private var _creationTime:String;
      
      private var var_4492:Date;
      
      private var _disposed:Boolean;
      
      public function class_2842(param1:IMessageDataWrapper)
      {
         super();
         var_5156 = param1.readInteger();
         var_4599 = param1.readInteger();
         var_3967 = param1.readString();
         _flatId = param1.readInteger();
         var_4220 = param1.readInteger();
         var_4104 = param1.readString();
         var_3890 = param1.readString();
         var _loc8_:int = param1.readInteger();
         var _loc5_:int = param1.readInteger();
         var _loc9_:Date = new Date();
         var _loc3_:Number = Number(_loc9_.getTime());
         var _loc2_:Number = _loc8_ * 60 * 1000;
         _loc3_ -= _loc2_;
         var _loc6_:Date = new Date(_loc3_);
         _creationTime = _loc6_.date + "-" + _loc6_.month + "-" + _loc6_.fullYear + " " + _loc6_.hours + ":" + _loc6_.minutes;
         var _loc7_:Number = Number(_loc9_.getTime());
         var _loc4_:Number = _loc5_ * 60 * 1000;
         _loc7_ += _loc4_;
         var_4492 = new Date(_loc7_);
         var_2851 = param1.readInteger();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get adId() : int
      {
         return var_5156;
      }
      
      public function get ownerAvatarId() : int
      {
         return var_4599;
      }
      
      public function get ownerAvatarName() : String
      {
         return var_3967;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get eventType() : int
      {
         return var_4220;
      }
      
      public function get eventName() : String
      {
         return var_4104;
      }
      
      public function get eventDescription() : String
      {
         return var_3890;
      }
      
      public function get creationTime() : String
      {
         return _creationTime;
      }
      
      public function get expirationDate() : Date
      {
         return var_4492;
      }
   }
}

