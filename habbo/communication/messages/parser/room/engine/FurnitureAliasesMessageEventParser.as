package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class FurnitureAliasesMessageEventParser implements IMessageParser
   {
      
      private var _aliases:class_55 = null;
      
      public function FurnitureAliasesMessageEventParser()
      {
         super();
         _aliases = new class_55();
      }
      
      public function get aliasCount() : int
      {
         return _aliases.length;
      }
      
      public function getName(param1:int) : String
      {
         if(param1 < 0 || param1 >= aliasCount)
         {
            return null;
         }
         return _aliases.getKey(param1);
      }
      
      public function getAlias(param1:int) : String
      {
         if(param1 < 0 || param1 >= aliasCount)
         {
            return null;
         }
         return _aliases.getWithIndex(param1);
      }
      
      public function flush() : Boolean
      {
         _aliases.reset();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc5_:String = null;
         _aliases.reset();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.readString();
            _loc5_ = param1.readString();
            _aliases.remove(_loc2_);
            _aliases.add(_loc2_,_loc5_);
            _loc4_++;
         }
         return true;
      }
   }
}

