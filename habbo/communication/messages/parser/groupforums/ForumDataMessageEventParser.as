package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ForumDataMessageEventParser implements IMessageParser
   {
      
      private var var_95:class_3591;
      
      public function ForumDataMessageEventParser()
      {
         super();
      }
      
      public function get forumData() : class_3591
      {
         return var_95;
      }
      
      public function flush() : Boolean
      {
         var_95 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_95 = class_3591.readFromMessage(param1);
         return true;
      }
   }
}

