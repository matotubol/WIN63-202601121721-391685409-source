package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   import package_189.WiredVariable;
   
   public class WiredAllVariablesDiffsEventParser implements IMessageParser
   {
      
      private var _allVariablesHash:int;
      
      private var var_2961:Boolean;
      
      private var var_2619:Vector.<String>;
      
      private var var_2206:Dictionary;
      
      public function WiredAllVariablesDiffsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _allVariablesHash = 0;
         var_2961 = false;
         var_2619 = null;
         var_2206 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _allVariablesHash = param1.readInteger();
         var_2961 = param1.readBoolean();
         var _loc2_:int = param1.readInteger();
         var_2619 = new Vector.<String>();
         var _loc5_:int = 0;
         while(0 < _loc2_)
         {
            var_2619.push(param1.readString());
            _loc5_++;
         }
         var _loc3_:int = param1.readInteger();
         var_2206 = new Dictionary();
         _loc5_ = 0;
         while(0 < _loc3_)
         {
            var _loc6_:int = param1.readInteger();
            var _loc4_:WiredVariable = new WiredVariable(param1);
            var_2206[null] = 0;
            _loc5_++;
         }
         return true;
      }
      
      public function get isLastChunk() : Boolean
      {
         return var_2961;
      }
      
      public function get removedVariables() : Vector.<String>
      {
         return var_2619;
      }
      
      public function get addedOrUpdated() : Dictionary
      {
         return var_2206;
      }
      
      public function get allVariablesHash() : int
      {
         return _allVariablesHash;
      }
   }
}

