package com.sulake.habbo.communication.messages.parser.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2748
   {
      
      public static var var_4277:int = 0;
      
      public static var name_7:int = 1;
      
      public static var var_5313:int = 2;
      
      public static var var_5350:int = 3;
      
      private var var_197:int;
      
      private var _creationTime:Number;
      
      private var var_4884:String;
      
      private var var_4140:int;
      
      private var var_4918:String;
      
      private var var_4962:Number;
      
      private var var_4815:Boolean;
      
      private var var_4491:Boolean;
      
      private var var_4307:int;
      
      private var var_4160:Number;
      
      private var var_4845:Number;
      
      public function class_2748(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readLong();
         _creationTime = param1.readLong();
         var_4884 = param1.readString();
         var_4140 = param1.readInteger();
         var_4918 = param1.readString();
         var_4962 = param1.readLong();
         var_4815 = param1.readBoolean();
         var_4491 = param1.readBoolean();
         var_4307 = param1.readByte();
         var_4160 = param1.readLong();
         var_4845 = param1.readLong();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get creationTime() : Number
      {
         return _creationTime;
      }
      
      public function get userMessage() : String
      {
         return var_4884;
      }
      
      public function get userCategory() : int
      {
         return var_4140;
      }
      
      public function get reportedAccountName() : String
      {
         return var_4918;
      }
      
      public function get closeTime() : Number
      {
         return var_4962;
      }
      
      public function get sanctioned() : Boolean
      {
         return var_4815;
      }
      
      public function get sanctionGivenByAutoModeration() : Boolean
      {
         return var_4491;
      }
      
      public function get appealStatus() : int
      {
         return var_4307;
      }
      
      public function get appealCreationTime() : Number
      {
         return var_4160;
      }
      
      public function get appealResolutionTime() : Number
      {
         return var_4845;
      }
   }
}

