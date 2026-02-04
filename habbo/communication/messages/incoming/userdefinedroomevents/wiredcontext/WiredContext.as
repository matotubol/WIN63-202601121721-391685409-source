package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import package_188.AllVariablesInRoom;
   import package_188.SharedGlobalPlaceholderList;
   import package_188.SharedVariableList;
   import package_188.VariableInfoAndHolders;
   import package_188.VariableInfoAndValue;
   import package_188.VariableList;
   
   public class WiredContext
   {
      
      public static var EMPTY:WiredContext = new WiredContext(null);
      
      private var var_3988:AllVariablesInRoom = null;
      
      private var var_4400:VariableInfoAndHolders = null;
      
      private var var_4165:VariableInfoAndHolders = null;
      
      private var var_4769:VariableInfoAndValue = null;
      
      private var var_4509:VariableList = null;
      
      private var var_4308:SharedVariableList = null;
      
      private var var_4970:SharedGlobalPlaceholderList = null;
      
      public function WiredContext(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1.readInteger();
            switch(_loc2_)
            {
               case class_4084.var_5329:
                  var_3988 = new AllVariablesInRoom(param1);
                  break;
               case class_4084.var_5318:
                  var_4400 = new VariableInfoAndHolders(param1);
                  break;
               case class_4084.var_5292:
                  var_4165 = new VariableInfoAndHolders(param1);
                  break;
               case class_4084.var_5366:
                  var_4769 = new VariableInfoAndValue(param1);
                  break;
               case class_4084.var_5353:
                  var_4308 = new SharedVariableList(param1);
                  break;
               case class_4084.var_5330:
                  var_4509 = VariableList.createFromMessage(param1);
                  break;
               case class_4084.var_5333:
                  var_4970 = new SharedGlobalPlaceholderList(param1);
            }
            _loc3_++;
         }
      }
      
      public function get roomVariablesList() : AllVariablesInRoom
      {
         return var_3988;
      }
      
      public function get furniVariableInfo() : VariableInfoAndHolders
      {
         return var_4400;
      }
      
      public function get userVariableInfo() : VariableInfoAndHolders
      {
         return var_4165;
      }
      
      public function get globalVariableInfo() : VariableInfoAndValue
      {
         return var_4769;
      }
      
      public function get referenceVariablesList() : SharedVariableList
      {
         return var_4308;
      }
      
      public function get referencePlaceholderList() : SharedGlobalPlaceholderList
      {
         return var_4970;
      }
      
      public function get rulesetVariables() : VariableList
      {
         return var_4509;
      }
   }
}

