package com.sulake.habbo.roomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_2812;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_3388;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_2729;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import package_189.WiredVariable;
   import package_97.class_2627;
   import package_97.class_3038;
   
   public class WiredVariablesSynchronizer implements class_13
   {
      
      private static var STATUS_IDLE:int = 0;
      
      private static var STATUS_AWAIT_HASH:int = 1;
      
      private static var STATUS_AWAIT_DIFFS:int = 2;
      
      private static var REQUEST_OFFSET:int = 800;
      
      private static var INVALIDATE_REQUEST_OFFSET:int = 4000;
      
      private var _disposed:Boolean;
      
      private var var_820:Number = -1;
      
      private var _status:int = STATUS_IDLE;
      
      private var _allVariablesHash:int;
      
      private var var_610:Dictionary = null;
      
      private var _variableIdToHash:Dictionary = null;
      
      private var _listeners:Vector.<Function> = new Vector.<Function>();
      
      private var name_1:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Array;
      
      public function WiredVariablesSynchronizer(param1:HabboUserDefinedRoomEvents)
      {
         super();
         this.name_1 = param1;
         _messageEvents = [];
         _messageEvents.push(new class_2627(onAllVariablesHashEvent));
         _messageEvents.push(new class_3038(onAllVariablesDiffEvent));
         for each(var _loc2_ in _messageEvents)
         {
            name_1.communication.addHabboConnectionMessageEvent(_loc2_);
         }
      }
      
      public function getAllVariables(param1:Function, param2:Boolean = true, param3:int = 0) : Boolean
      {
         if(_status != STATUS_IDLE && var_820 < getTimer() - INVALIDATE_REQUEST_OFFSET)
         {
            _status = STATUS_IDLE;
         }
         if(_status != STATUS_IDLE)
         {
            addListener(param1);
            return false;
         }
         if(var_820 > getTimer() - REQUEST_OFFSET)
         {
            param1(sortedCachedVariables);
            return true;
         }
         if(!param2 && var_610 != null)
         {
            param1(sortedCachedVariables);
            return true;
         }
         var_820 = getTimer();
         _status = STATUS_AWAIT_HASH;
         addListener(param1);
         if(param3 != 0)
         {
            onAllVariablesHash(param3);
         }
         else
         {
            name_1.send(new class_2812());
         }
         return false;
      }
      
      public function getCachedVariableById(param1:String) : WiredVariable
      {
         return var_610[param1];
      }
      
      private function onAllVariablesHashEvent(param1:class_2627) : void
      {
         onAllVariablesHash(param1.getParser().allVariablesHash);
      }
      
      private function onAllVariablesHash(param1:int) : void
      {
         if(_status != STATUS_AWAIT_HASH)
         {
            return;
         }
         var_820 = getTimer();
         if(param1 == _allVariablesHash)
         {
            updateListeners();
            _status = STATUS_IDLE;
         }
         else
         {
            _allVariablesHash = param1;
            _status = STATUS_AWAIT_DIFFS;
            name_1.send(new class_3388(_variableIdToHash));
         }
      }
      
      private function onAllVariablesDiffEvent(param1:class_3038) : void
      {
         if(_status != STATUS_AWAIT_DIFFS)
         {
            return;
         }
         var_820 = getTimer();
         var _loc2_:class_2729 = param1.getParser();
         _allVariablesHash = _loc2_.allVariablesHash;
         if(var_610 == null)
         {
            var_610 = new Dictionary();
            _variableIdToHash = new Dictionary();
         }
         deleteVariablesInCache(_loc2_.removedVariables);
         updateVariablesInCache(_loc2_.addedOrUpdated);
         if(_loc2_.isLastChunk)
         {
            updateListeners();
            _status = STATUS_IDLE;
         }
      }
      
      private function deleteVariablesInCache(param1:Vector.<String>) : void
      {
         for each(var _loc2_ in param1)
         {
            if(_loc2_ in var_610)
            {
               delete var_610[_loc2_];
               delete _variableIdToHash[_loc2_];
            }
         }
      }
      
      private function updateVariablesInCache(param1:Dictionary) : void
      {
         var _loc3_:int = 0;
         for(var _loc2_ in param1)
         {
            _loc3_ = int(param1[_loc2_]);
            var_610[_loc2_.variableId] = _loc2_;
            _variableIdToHash[_loc2_.variableId] = _loc3_;
         }
      }
      
      private function get sortedCachedVariables() : Vector.<WiredVariable>
      {
         if(var_610 == null)
         {
            return new Vector.<WiredVariable>();
         }
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc2_ in var_610)
         {
            _loc1_.push(_loc2_);
         }
         Util.sortVariables(_loc1_);
         return _loc1_;
      }
      
      private function addListener(param1:Function) : void
      {
         if(_listeners.indexOf(param1) == -1)
         {
            _listeners.push(param1);
         }
      }
      
      public function removeListener(param1:Function) : void
      {
         var _loc2_:int = int(_listeners.indexOf(param1));
         if(_loc2_ != -1)
         {
            _listeners.removeAt(_loc2_);
         }
      }
      
      private function updateListeners() : void
      {
         var _loc1_:Vector.<WiredVariable> = sortedCachedVariables;
         for each(var _loc2_ in _listeners)
         {
            _loc2_(_loc1_);
         }
         _listeners.splice(0,_listeners.length);
      }
      
      public function clear() : void
      {
         _listeners = new Vector.<Function>();
         var_610 = null;
         _variableIdToHash = null;
         _allVariablesHash = 0;
         var_820 = -1;
         _status = STATUS_IDLE;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _listeners = null;
         var_820 = -1;
         _status = STATUS_IDLE;
         _allVariablesHash = 0;
         var_610 = null;
         _variableIdToHash = null;
         for each(var _loc1_ in _messageEvents)
         {
            name_1.communication.removeHabboConnectionMessageEvent(_loc1_);
         }
         _messageEvents = null;
         name_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

