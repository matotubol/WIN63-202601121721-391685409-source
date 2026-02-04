package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class NewVariablePickerHelper
   {
      
      private static var MAX_HISTORY:int = 20;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1856:class_55;
      
      private var var_2714:class_55;
      
      private var var_1825:class_55;
      
      public function NewVariablePickerHelper(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         var_1825 = new class_55();
         var_2714 = new class_55();
         var_1856 = new class_55();
      }
      
      public function addToHistory(param1:WiredVariable) : void
      {
         var _loc3_:int = param1.variableTarget;
         var _loc5_:String = param1.variableId;
         var _loc6_:int = _roomEvents.roomId;
         if(_loc6_ == 0)
         {
            return;
         }
         if(!var_1856.hasKey(_loc6_))
         {
            var_1856.add(_loc6_,new class_55());
         }
         var _loc2_:class_55 = var_1856.getValue(_loc6_);
         if(!_loc2_.hasKey(_loc3_))
         {
            _loc2_.add(_loc3_,new Vector.<String>());
         }
         var _loc4_:Vector.<String> = _loc2_.getValue(_loc3_);
         var _loc7_:int = int(_loc4_.indexOf(_loc5_));
         if(_loc7_ >= 0)
         {
            _loc4_.removeAt(_loc7_);
         }
         _loc4_.splice(0,0,_loc5_);
         if(_loc4_.length > MAX_HISTORY)
         {
            _loc4_.pop();
         }
      }
      
      public function getHistory(param1:int) : Vector.<String>
      {
         var _loc3_:int = _roomEvents.roomId;
         if(_loc3_ == 0)
         {
            return Vector.<String>([]);
         }
         if(!var_1856.hasKey(_loc3_))
         {
            return Vector.<String>([]);
         }
         var _loc2_:class_55 = var_1856.getValue(_loc3_);
         if(!_loc2_.hasKey(param1))
         {
            return Vector.<String>([]);
         }
         return _loc2_.getValue(param1);
      }
      
      public function acquireNodeView(param1:WiredStyle) : IRegionWindow
      {
         var _loc4_:class_1741 = null;
         if(var_1825.hasKey(param1))
         {
            var _loc3_:Vector.<IRegionWindow> = var_1825.getValue(param1);
            if(undefined.length > 0)
            {
               return undefined.pop();
            }
         }
         if(!var_2714.hasKey(param1))
         {
            _loc4_ = _roomEvents.wiredCtrl.presetManager.createLayout("search_tree_dropdown");
            var_2714.add(param1,_loc4_.findChildByName("node_template"));
         }
         var _loc2_:IRegionWindow = var_2714.getValue(param1);
         return _loc2_.clone() as IRegionWindow;
      }
      
      public function releaseNodeView(param1:WiredStyle, param2:IRegionWindow) : void
      {
         if(!var_1825.hasKey(param1))
         {
            var_1825.add(param1,new Vector.<IRegionWindow>());
         }
         var_1825.getValue(param1).push(param2);
      }
   }
}

