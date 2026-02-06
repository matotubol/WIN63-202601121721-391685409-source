package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionStartedMessageEventParser implements IMessageParser
   {
      
      private var var_4044:int;
      
      private var _requesterName:String;
      
      private var var_5165:String;
      
      private var var_4931:int;
      
      private var _guideName:String;
      
      private var var_3855:String;
      
      public function GuideSessionStartedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4044 = param1.readInteger();
         _requesterName = param1.readString();
         var_5165 = param1.readString();
         var_4931 = param1.readInteger();
         _guideName = param1.readString();
         var_3855 = param1.readString();
         return true;
      }
      
      public function get requesterUserId() : int
      {
         return var_4044;
      }
      
      public function get requesterName() : String
      {
         return _requesterName;
      }
      
      public function get requesterFigure() : String
      {
         return var_5165;
      }
      
      public function get guideUserId() : int
      {
         return var_4931;
      }
      
      public function get guideName() : String
      {
         return _guideName;
      }
      
      public function get guideFigure() : String
      {
         return var_3855;
      }
   }
}

