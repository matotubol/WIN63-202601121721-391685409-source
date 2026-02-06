package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.incoming.users.class_3604;
   
   [SecureSWF(rename="true")]
   public class RelationshipStatusInfoEventParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      private var var_950:class_55;
      
      public function RelationshipStatusInfoEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_950)
         {
            var_950.dispose();
            var_950 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var_950 = new class_55();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:class_3604 = new class_3604(param1);
            var_950.add(null.relationshipStatusType,null);
            _loc3_++;
         }
         return true;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get relationshipStatusMap() : class_55
      {
         return var_950;
      }
   }
}

