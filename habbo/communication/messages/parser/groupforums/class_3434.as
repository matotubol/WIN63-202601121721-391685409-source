package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3434
   {
      
      private var var_2326:int;
      
      private var var_4900:int;
      
      private var var_4500:String;
      
      private var var_3852:int;
      
      private var _header:String;
      
      private var var_5063:int;
      
      private var var_4053:int;
      
      private var var_2033:int;
      
      private var var_1847:int;
      
      private var var_1936:String;
      
      private var var_2123:int;
      
      private var var_61:int;
      
      private var var_4142:int;
      
      private var var_4045:String;
      
      private var var_3876:int;
      
      private var var_5108:Boolean;
      
      private var var_5002:Boolean;
      
      public function class_3434()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : class_3434
      {
         var _loc2_:class_3434 = new class_3434();
         _loc2_.threadId = param1.readInteger();
         _loc2_.threadAuthorId = param1.readInteger();
         _loc2_.threadAuthorName = param1.readString();
         _loc2_.header = param1.readString();
         _loc2_.isSticky = param1.readBoolean();
         _loc2_.isLocked = param1.readBoolean();
         _loc2_.creationTimeAsSecondsAgo = param1.readInteger();
         _loc2_.nMessages = param1.readInteger();
         _loc2_.nUnreadMessages = param1.readInteger();
         _loc2_.lastMessageId = param1.readInteger();
         _loc2_.lastMessageAuthorId = param1.readInteger();
         _loc2_.lastMessageAuthorName = param1.readString();
         _loc2_.lastMessageTimeAsSecondsAgo = param1.readInteger();
         _loc2_.state = param1.readByte();
         _loc2_.adminId = param1.readInteger();
         _loc2_.adminName = param1.readString();
         _loc2_.adminOperationTimeAsSecondsAgo = param1.readInteger();
         return _loc2_;
      }
      
      public function get adminOperationTimeAsSecondsAgo() : int
      {
         return var_3876;
      }
      
      public function set adminOperationTimeAsSecondsAgo(param1:int) : void
      {
         var_3876 = param1;
      }
      
      public function get lastMessageTimeAsSecondsAgo() : int
      {
         return var_2123;
      }
      
      public function set lastMessageTimeAsSecondsAgo(param1:int) : void
      {
         var_2123 = param1;
      }
      
      public function get threadId() : int
      {
         return var_2326;
      }
      
      public function set threadId(param1:int) : void
      {
         var_2326 = param1;
      }
      
      public function get threadAuthorId() : int
      {
         return var_4900;
      }
      
      public function set threadAuthorId(param1:int) : void
      {
         var_4900 = param1;
      }
      
      public function get threadAuthorName() : String
      {
         return var_4500;
      }
      
      public function set threadAuthorName(param1:String) : void
      {
         var_4500 = param1;
      }
      
      public function get creationTimeAsSecondsAgo() : int
      {
         return var_3852;
      }
      
      public function set creationTimeAsSecondsAgo(param1:int) : void
      {
         var_3852 = param1;
      }
      
      public function get header() : String
      {
         return _header;
      }
      
      public function set header(param1:String) : void
      {
         _header = param1;
      }
      
      public function get lastMessageId() : int
      {
         return var_2033;
      }
      
      public function set lastMessageId(param1:int) : void
      {
         var_2033 = param1;
      }
      
      public function get lastMessageAuthorId() : int
      {
         return var_1847;
      }
      
      public function set lastMessageAuthorId(param1:int) : void
      {
         var_1847 = param1;
      }
      
      public function get lastMessageAuthorName() : String
      {
         return var_1936;
      }
      
      public function set lastMessageAuthorName(param1:String) : void
      {
         var_1936 = param1;
      }
      
      public function get nMessages() : int
      {
         return var_5063;
      }
      
      public function set nMessages(param1:int) : void
      {
         var_5063 = param1;
      }
      
      public function get nUnreadMessages() : int
      {
         return var_4053;
      }
      
      public function set nUnreadMessages(param1:int) : void
      {
         var_4053 = param1;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function set state(param1:int) : void
      {
         var_61 = param1;
      }
      
      public function get adminId() : int
      {
         return var_4142;
      }
      
      public function set adminId(param1:int) : void
      {
         var_4142 = param1;
      }
      
      public function get adminName() : String
      {
         return var_4045;
      }
      
      public function set adminName(param1:String) : void
      {
         var_4045 = param1;
      }
      
      public function get isSticky() : Boolean
      {
         return var_5108;
      }
      
      public function set isSticky(param1:Boolean) : void
      {
         var_5108 = param1;
      }
      
      public function get isLocked() : Boolean
      {
         return var_5002;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         var_5002 = param1;
      }
   }
}

