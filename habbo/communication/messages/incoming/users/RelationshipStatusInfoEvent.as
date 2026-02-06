package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.parser.users.RelationshipStatusInfoEventParser;
   
   [SecureSWF(rename="true")]
   public class RelationshipStatusInfoEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RelationshipStatusInfoEvent(param1:Function)
      {
         super(param1,RelationshipStatusInfoEventParser);
      }
      
      public function get userId() : int
      {
         return (var_15 as RelationshipStatusInfoEventParser).userId;
      }
      
      public function get relationshipStatusMap() : class_55
      {
         return (var_15 as RelationshipStatusInfoEventParser).relationshipStatusMap;
      }
   }
}

