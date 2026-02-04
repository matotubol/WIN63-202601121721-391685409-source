package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import flash.utils.Dictionary;
   import package_188.SharedVariableList;
   import package_188.class_3414;
   import package_189.SharedVariable;
   import package_189.WiredVariable;
   
   public class ReferenceVariable extends DefaultVariableType
   {
      
      private var _cont:class_1812;
      
      private var var_939:VariablePicker;
      
      private var var_1516:WiredVariable;
      
      private var var_3112:int;
      
      private var _rooms:Vector.<Object>;
      
      private var var_3658:Dictionary;
      
      private var var_3020:Boolean = false;
      
      public function ReferenceVariable()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4086.REFERENCE_VARIABLE;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         var_939 = new VariablePicker(param3,variableMenu,variableVisibilityFilter,onVariableSelected);
         var_1516 = null;
         roomMenu.addEventListener("WE_SELECTED",onRoomSelect);
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_939.selectedVariableId];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(readOnlyCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         super.onEditStart(param1);
         var_3020 = false;
         var _loc4_:String = param1.variableIds[0];
         var _loc3_:* = param1.intParams[0] != 0;
         Util.select(readOnlyCheckbox,_loc3_);
         initRooms(_loc4_,param1);
         var _loc2_:SharedVariableList = param1.wiredContext.referenceVariablesList;
         var_939.init(_loc2_ == null ? class_3414.EMPTY : _loc2_,_loc4_,VariablePicker.UNSPECIFIED_TYPE);
         var_1516 = var_939.selectedVariable;
         initialVariableName = param1.stringParam;
         var_3020 = true;
         editable = _loc2_ != null;
      }
      
      private function set editable(param1:Boolean) : void
      {
         if(param1)
         {
            variableMenu.enable();
            roomMenu.enable();
            readOnlyCheckbox.enable();
            variableNameTxt.enable();
         }
         else
         {
            variableMenu.disable();
            roomMenu.disable();
            readOnlyCheckbox.disable();
            variableNameTxt.disable();
         }
         var _loc2_:Number = param1 ? 1 : 0.5;
         variableMenu.blend = _loc2_;
         roomMenu.blend = _loc2_;
         readOnlyCheckbox.blend = _loc2_;
      }
      
      private function initRooms(param1:String, param2:class_2397) : void
      {
         var room:Object;
         var sharedVariable:SharedVariable;
         var roomNames:Vector.<String>;
         var i:int;
         var variableId:String = param1;
         var updated:class_2397 = param2;
         var_3658 = new Dictionary();
         _rooms = new Vector.<Object>();
         var selectedRoom:Object = null;
         var roomMap:Dictionary = new Dictionary();
         var selectRoomIndex:int = -1;
         var context:SharedVariableList = updated.wiredContext.referenceVariablesList;
         if(context != null)
         {
            for each(sharedVariable in context.sharedVariables)
            {
               if(!(sharedVariable.roomId in roomMap))
               {
                  room = {
                     "id":sharedVariable.roomId,
                     "name":sharedVariable.roomName
                  };
                  roomMap[sharedVariable.roomId] = room;
                  _rooms.push(room);
               }
               else
               {
                  room = roomMap[sharedVariable.roomId];
               }
               var_3658[sharedVariable.wiredVariable] = room;
               if(sharedVariable.wiredVariable.variableId == variableId)
               {
                  selectedRoom = room;
               }
            }
            _rooms.sort(function(param1:Object, param2:Object):int
            {
               return param1.name.localeCompare(param2.name);
            });
            roomNames = new Vector.<String>();
            i = 0;
            while(i < _rooms.length)
            {
               room = _rooms[i];
               roomNames.push(room.name);
               if(room == selectedRoom)
               {
                  selectRoomIndex = i;
               }
               i += 1;
            }
            roomMenu.populateWithVector(roomNames);
            roomMenu.selection = selectRoomIndex;
         }
         var_3112 = selectRoomIndex;
      }
      
      override public function readStringParamFromForm() : String
      {
         return variableNameTxt.text;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get variableMenu() : class_2261
      {
         return class_2261(_cont.findChildByName("menu_variables"));
      }
      
      private function get roomMenu() : class_2261
      {
         return class_2261(_cont.findChildByName("menu_room"));
      }
      
      private function get readOnlyCheckbox() : class_1885
      {
         return class_1885(_cont.findChildByName("read_only_checkbox"));
      }
      
      private function onRoomSelect(param1:class_1758) : void
      {
         if(var_3112 != roomMenu.selection && var_3020)
         {
            var_939.reload(WiredVariable.var_636);
            onVariableSelected(null);
         }
         var_3112 = roomMenu.selection;
      }
      
      private function variableVisibilityFilter(param1:WiredVariable) : Boolean
      {
         var _loc2_:int = roomMenu.selection;
         if(_loc2_ < 0 || _loc2_ >= _rooms.length)
         {
            return false;
         }
         var _loc3_:Object = _rooms[_loc2_];
         return var_3658[param1] == _loc3_;
      }
      
      private function onVariableSelected(param1:WiredVariable) : void
      {
         if(variableNameTxt.text.length == 0 || var_1516 != null && var_1516.variableName == variableNameTxt.text)
         {
            variableNameTxt.text = param1?.variableName;
         }
         var_1516 = param1;
      }
   }
}

