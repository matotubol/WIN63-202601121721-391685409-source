package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2670
   {
      
      private var _groupId:int;
      
      private var var_2582:int;
      
      private var var_4313:int;
      
      private var var_4809:int;
      
      private var var_2326:int;
      
      private var _creationTime:int;
      
      private var var_940:String;
      
      private var var_4940:String;
      
      private var var_4575:String;
      
      private var var_61:int;
      
      private var var_4142:int;
      
      private var var_4045:String;
      
      private var var_4653:int;
      
      private var var_4725:int;
      
      public function class_2670()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : class_2670
      {
         var _loc2_:class_2670 = new class_2670();
         _loc2_.messageId = param1.readInteger();
         _loc2_.messageIndex = param1.readInteger();
         _loc2_.authorId = param1.readInteger();
         _loc2_.authorName = param1.readString();
         _loc2_.authorFigure = param1.readString();
         _loc2_.creationTimeAsSecondsAgo = param1.readInteger();
         _loc2_.messageText = param1.readString();
         _loc2_.state = param1.readByte();
         _loc2_.adminId = param1.readInteger();
         _loc2_.adminName = param1.readString();
         _loc2_.adminOperationTimeAsSeccondsAgo = param1.readInteger();
         _loc2_.authorPostCount = param1.readInteger();
         return _loc2_;
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
      
      public function get adminOperationTimeAsSeccondsAgo() : int
      {
         return var_4653;
      }
      
      public function set adminOperationTimeAsSeccondsAgo(param1:int) : void
      {
         var_4653 = param1;
      }
      
      public function get MessageId() : int
      {
         return var_2582;
      }
      
      public function set MessageId(param1:int) : void
      {
         var_2582 = param1;
      }
      
      public function get creationTime() : int
      {
         return _creationTime;
      }
      
      public function set creationTime(param1:int) : void
      {
         _creationTime = param1;
      }
      
      public function get authorName() : String
      {
         return var_4940;
      }
      
      public function set authorName(param1:String) : void
      {
         var_4940 = param1;
      }
      
      public function get authorFigure() : String
      {
         return var_4575;
      }
      
      public function set authorFigure(param1:String) : void
      {
         var_4575 = param1;
      }
      
      public function get threadId() : int
      {
         return var_2326;
      }
      
      public function set threadId(param1:int) : void
      {
         var_2326 = param1;
      }
      
      public function get messageId() : int
      {
         return var_2582;
      }
      
      public function set messageId(param1:int) : void
      {
         var_2582 = param1;
      }
      
      public function get messageIndex() : int
      {
         return var_4313;
      }
      
      public function set messageIndex(param1:int) : void
      {
         var_4313 = param1;
      }
      
      public function set groupID(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get authorId() : int
      {
         return var_4809;
      }
      
      public function set authorId(param1:int) : void
      {
         var_4809 = param1;
      }
      
      public function get creationTimeAsSecondsAgo() : int
      {
         return _creationTime;
      }
      
      public function set creationTimeAsSecondsAgo(param1:int) : void
      {
         _creationTime = param1;
      }
      
      public function get messageText() : String
      {
         return var_940;
      }
      
      public function set messageText(param1:String) : void
      {
         var_940 = param1;
      }
      
      public function get authorPostCount() : int
      {
         return var_4725;
      }
      
      public function set authorPostCount(param1:int) : void
      {
         var_4725 = param1;
      }
   }
}

