package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariableHoldersMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEventParser;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.common.VariableTypePicker;
   import com.sulake.habbo.roomevents.wired_menu.variables_management.overview.VariableManagementConfig;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import package_117.WiredGetVariableOwnersPageComposer;
   import package_189.ObjectIdAndValuePair;
   import package_189.WiredVariable;
   import package_189.class_4013;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEvent;
   
   public class WiredMenuOverviewTab extends WiredMenuDefaultTab implements class_31
   {
      
      private static var POLL_MS:uint = 500;
      
      private static var MAX_HIGHLIGHTS:uint = 1000;
      
      private static var MAX_HIGHLIGHTS_WITH_VALUE:uint = 400;
      
      private static var MAX_TEXT_CONNECTIONS:uint = 400;
      
      public static var LIST_COLUMN_NAME:String = "variable";
      
      public static var PROPERTIES_COLUMN_PROPERTY:String = "property";
      
      public static var PROPERTIES_COLUMN_VALUE:String = "value";
      
      public static var var_5284:String = "value";
      
      public static var var_4092:String = "text";
      
      private var var_401:TableView;
      
      private var var_1598:TableView;
      
      private var var_1370:TableView;
      
      private var var_371:VariableTypePicker;
      
      private var _highlighter:VariableHoldersHighlighter;
      
      private var _highlightEnabled:Boolean;
      
      private var var_4210:int = 0;
      
      private var var_3894:int = 0;
      
      private var var_1453:Vector.<WiredVariable>;
      
      private var var_2390:String = null;
      
      private var var_3060:WiredVariable = null;
      
      public function WiredMenuOverviewTab(param1:WiredMenuController, param2:class_1812)
      {
         super(param1,param2);
         _highlighter = new VariableHoldersHighlighter(param1.roomEvents);
         var_401 = new TableView(param1.windowManager,variableListContainer);
         var_1598 = new TableView(param1.windowManager,propertiesTableContainer);
         var_1370 = new TableView(param1.windowManager,textsTableContainer);
         var_371 = new VariableTypePicker(typePickerContainer,onSelectVariableType);
         createVariableList();
         createPropertiesTable();
         createTextTable();
         addMessageEvent(new WiredAllVariableHoldersEvent(onAllVariableHolders));
         highlightHoldersButton.addEventListener("WME_CLICK",onHighlightClick);
         manageButton.addEventListener("WME_CLICK",onManageClick);
      }
      
      private function createVariableList() : void
      {
         var _loc1_:Array = [new TableColumn(LIST_COLUMN_NAME,"",1,"left")];
         var_401.initialize(Vector.<TableColumn>(_loc1_),false);
         var_401.onRowSelectedCallback = onSelectVariable;
      }
      
      private function createPropertiesTable() : void
      {
         var _loc1_:Array = [new TableColumn(PROPERTIES_COLUMN_PROPERTY,loc("wiredmenu.variable_overview.properties.column.property"),0.52,"left"),new TableColumn(PROPERTIES_COLUMN_VALUE,loc("wiredmenu.variable_overview.properties.column.value"),0.48,"left")];
         var_1598.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      private function createTextTable() : void
      {
         var _loc1_:Array = [new TableColumn(var_5284,loc("wiredmenu.variable_overview.text.column.value"),0.2,"left"),new TableColumn(var_4092,loc("wiredmenu.variable_overview.text.column.text"),0.8,"right")];
         var_1370.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         clearData();
         updateLoadingState();
         requestData();
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_1453 != null;
      }
      
      private function clearData() : void
      {
         var_1453 = null;
      }
      
      private function requestData() : void
      {
         var_4210 = getTimer();
         controller.variablesSynchronizer.getAllVariables(onAllVariables);
      }
      
      private function requestHolders() : void
      {
         var_3894 = getTimer();
         controller.send(new WiredGetAllVariableHoldersMessageComposer(selectedVariableId));
      }
      
      private function onAllVariables(param1:Vector.<WiredVariable>) : void
      {
         var_1453 = param1;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            initializeInterface();
         }
      }
      
      private function onAllVariableHolders(param1:WiredAllVariableHoldersEvent) : void
      {
         var _loc9_:int = 0;
         var _loc8_:Number = NaN;
         if(!_highlightEnabled || !isViewing)
         {
            return;
         }
         var _loc2_:WiredAllVariableHoldersEventParser = param1.getParser();
         var _loc4_:Vector.<ObjectIdAndValuePair> = _loc2_.variableInfoAndHolders.holders;
         var _loc6_:WiredVariable = _loc2_.variableInfoAndHolders.variable;
         if(_loc6_.variableId != selectedVariableId)
         {
            return;
         }
         if(!_loc6_.hasValue && _loc4_.length > MAX_HIGHLIGHTS || _loc6_.hasValue && _loc4_.length > MAX_HIGHLIGHTS_WITH_VALUE)
         {
            controller.roomEvents.notifications.addItem(loc("wiredmenu.variable_overview.highlight.error.too_many"),"info","icon_wired_notification_png");
            stopHighlight();
            return;
         }
         var _loc5_:Dictionary = new Dictionary();
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc7_ in _loc4_)
         {
            _loc9_ = _loc7_.objectId;
            _loc8_ = _loc6_.hasValue ? _loc7_.value : NaN;
            if(_loc6_.variableTarget == WiredInputSourcePicker.var_128)
            {
               _highlighter.highlightObject(_loc9_,Util.variableValueWithString(_loc6_,_loc8_));
               _loc5_[_loc9_] = true;
            }
            else if(_loc6_.variableTarget == WiredInputSourcePicker.USER_SOURCE)
            {
               _highlighter.highlightUser(_loc9_,Util.variableValueWithString(_loc6_,_loc8_));
               _loc3_[_loc9_] = true;
            }
         }
         _highlighter.removeRemovedHolders(_loc5_,_loc3_);
      }
      
      private function get selectedVariableId() : String
      {
         var _loc1_:WiredVariable = selectedVariable;
         return _loc1_?.variableId;
      }
      
      private function get selectedVariable() : WiredVariable
      {
         if(var_401.selected == null)
         {
            return null;
         }
         return VariableTableObject(var_401.selected).variable;
      }
      
      override protected function initializeInterface() : void
      {
         if(var_2390 != null)
         {
            findFocusVariable(var_2390);
            var_2390 = null;
         }
         updateVariableListUI();
         updatePropertiesTableUI();
         updateTextTableUI();
         updateButtonsUI();
      }
      
      private function updateVariableListUI() : void
      {
         var _loc5_:ITableObject = null;
         var _loc1_:ITableObject = var_401.selected;
         var _loc3_:Vector.<ITableObject> = new Vector.<ITableObject>();
         var _loc2_:ITableObject = null;
         for each(var _loc4_ in var_1453)
         {
            if(!_loc4_.isInvisible)
            {
               if(_loc4_.variableTarget == var_371.selectedType)
               {
                  _loc5_ = new VariableTableObject(_loc4_,controller.roomEvents);
                  if(_loc4_ == var_3060)
                  {
                     _loc2_ = _loc5_;
                  }
                  _loc3_.push(_loc5_);
               }
            }
         }
         var_401.setObjects(_loc3_);
         if(_loc2_ != null)
         {
            var_401.trySelect(_loc2_);
         }
         else if(_loc1_ == null && _loc3_.length > 0)
         {
            var_401.trySelect(_loc3_[0]);
         }
         else if(_loc1_ != null)
         {
            if(var_401.selected == null)
            {
               var_401.trySelect(_loc3_[0]);
            }
         }
         var_3060 = null;
      }
      
      private function updateButtonsUI() : void
      {
         Util.disableSection(highlightHoldersButton,!canHighlightCurrentVariable);
         Util.disableSection(manageButton,!canManageCurrentVariable);
      }
      
      private function onSelectVariable(param1:VariableTableObject) : void
      {
         var_1370.resetScrollingNextUpdate();
         updatePropertiesTableUI();
         updateTextTableUI();
         if(_highlightEnabled)
         {
            _highlighter.clear();
            if(canHighlightCurrentVariable)
            {
               requestHolders();
            }
         }
         updateButtonsUI();
      }
      
      private function get canHighlightCurrentVariable() : Boolean
      {
         var _loc1_:WiredVariable = getSelectedVariable();
         return _loc1_ != null && _loc1_.variableType != class_4013.INTERNAL && (_loc1_.variableTarget == WiredInputSourcePicker.USER_SOURCE || _loc1_.variableTarget == WiredInputSourcePicker.var_128);
      }
      
      private function get canManageCurrentVariable() : Boolean
      {
         var _loc1_:WiredVariable = getSelectedVariable();
         return _loc1_ != null && _loc1_.variableTarget == WiredInputSourcePicker.USER_SOURCE && _loc1_.isPersisted;
      }
      
      private function onHighlightClick(param1:WindowMouseEvent) : void
      {
         if(_highlightEnabled)
         {
            stopHighlight();
         }
         else
         {
            startHighlight();
         }
      }
      
      private function onManageClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:WiredVariable = getSelectedVariable();
         if(!canManageCurrentVariable)
         {
            return;
         }
         controller.send(new WiredGetVariableOwnersPageComposer(_loc2_.variableId,1,VariableManagementConfig.PAGE_SIZE,0,-1));
      }
      
      private function startHighlight() : void
      {
         _highlightEnabled = true;
         highlightHoldersButton.caption = loc("wiredmenu.variable_overview.unhighlight_holders");
         requestHolders();
      }
      
      private function stopHighlight() : void
      {
         _highlightEnabled = false;
         highlightHoldersButton.caption = loc("wiredmenu.variable_overview.highlight_holders");
         _highlighter.clear();
      }
      
      private function onSelectVariableType(param1:int) : void
      {
         var_401.resetScrollingNextUpdate();
         initializeInterface();
      }
      
      private function updatePropertiesTableUI() : void
      {
         var _loc2_:WiredVariable = getSelectedVariable();
         if(_loc2_ == null)
         {
            var_1598.clear();
            return;
         }
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         _loc1_.push(new PropertyTableObject("name",_loc2_.variableName,localization,true));
         _loc1_.push(new PropertyTableObject("type",getTypeString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("target",getTargetString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("availability",getAvailabilityString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("has_value",_loc2_.hasValue,localization));
         _loc1_.push(new PropertyTableObject("can_write_to",_loc2_.canWriteValue,localization));
         _loc1_.push(new PropertyTableObject("can_create_delete",_loc2_.canCreateAndDelete,localization));
         _loc1_.push(new PropertyTableObject("can_intercept",_loc2_.canInterceptChanges,localization));
         _loc1_.push(new PropertyTableObject("is_always_available",_loc2_.alwaysAvailable,localization));
         _loc1_.push(new PropertyTableObject("can_read_creation_time",_loc2_.canReadCreationTime,localization));
         _loc1_.push(new PropertyTableObject("can_read_last_update_time",_loc2_.canReadLastUpdateTime,localization));
         _loc1_.push(new PropertyTableObject("is_text_connected",_loc2_.hasTextConnector,localization));
         var_1598.setObjects(_loc1_);
      }
      
      private function getTypeString(param1:WiredVariable) : String
      {
         return loc("wiredfurni.params.variables.idtype." + param1.variableType);
      }
      
      private function getTargetString(param1:WiredVariable) : String
      {
         switch(param1.variableTarget)
         {
            case WiredInputSourcePicker.var_128:
               return loc("wiredfurni.params.sourcetype.furni");
            case WiredInputSourcePicker.USER_SOURCE:
               return loc("wiredfurni.params.sourcetype.users");
            case class_4050.GLOBAL_SOURCE:
               return loc("wiredfurni.params.sourcetype.global");
            case class_4050.CONTEXT_SOURCE:
               return loc("wiredfurni.params.sourcetype.context");
            default:
               return "";
         }
      }
      
      private function getAvailabilityString(param1:WiredVariable) : String
      {
         return localization.getLocalization("wiredfurni.params.variables.availability." + param1.availabilityType,loc("wiredfurni.params.variables.availability.misc"));
      }
      
      private function updateTextTableUI() : void
      {
         var _loc4_:String = null;
         var _loc6_:WiredVariable = getSelectedVariable();
         var _loc3_:Boolean = _loc6_ == null || !_loc6_.hasTextConnector;
         if(_loc3_)
         {
            var_1370.clear();
            Util.disableSection(textsTableContainer);
            return;
         }
         if(!textsTableContainer.isEnabled())
         {
            Util.disableSection(textsTableContainer,false);
         }
         var _loc5_:class_55 = _loc6_.textConnector;
         var _loc2_:Array = _loc5_.getKeys();
         _loc2_.sort(16);
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         if(_loc2_.length <= MAX_TEXT_CONNECTIONS)
         {
            for each(var _loc7_ in _loc2_)
            {
               _loc4_ = _loc5_.getValue(_loc7_);
               _loc1_.push(new TextTableObject(_loc7_,_loc4_));
            }
         }
         var_1370.setObjects(_loc1_);
      }
      
      private function getSelectedVariable() : WiredVariable
      {
         var _loc1_:ITableObject = var_401.selected;
         if(_loc1_ == null)
         {
            return null;
         }
         return (_loc1_ as VariableTableObject).variable;
      }
      
      override public function stopViewing() : void
      {
         super.stopViewing();
         if(_highlightEnabled)
         {
            _highlighter.clear();
         }
      }
      
      public function jumpToVariableByName(param1:String) : void
      {
         if(isDataReady())
         {
            findFocusVariable(param1);
            initializeInterface();
         }
         else
         {
            var_2390 = param1;
         }
      }
      
      private function findFocusVariable(param1:String) : void
      {
         var _loc2_:WiredVariable = getVariableByNameOrPrefix(param1);
         if(_loc2_ == null)
         {
            return;
         }
         var_371.selectedType = _loc2_.variableTarget;
         var_3060 = _loc2_;
      }
      
      private function getVariableByNameOrPrefix(param1:String) : WiredVariable
      {
         for each(var _loc3_ in var_1453)
         {
            if(!_loc3_.isInvisible)
            {
               if(_loc3_.variableName == param1)
               {
                  return _loc3_;
               }
               if(_loc3_.variableName.indexOf(param1 + ".") == 0)
               {
                  var _loc2_:WiredVariable = _loc3_;
               }
            }
         }
         return null;
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var_371.update(param1);
         var _loc2_:int = getTimer();
         if(var_4210 < _loc2_ - POLL_MS)
         {
            requestData();
         }
         if(canHighlightCurrentVariable && _highlightEnabled && var_3894 < _loc2_ - POLL_MS)
         {
            requestHolders();
         }
         _highlighter.update(param1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         controller.variablesSynchronizer.removeListener(onAllVariables);
         var_371.dispose();
         var_371 = null;
         var_401.dispose();
         var_401 = null;
         var_1598.dispose();
         var_1598 = null;
         var_1370.dispose();
         var_1370 = null;
         var_1453 = null;
         _highlighter.dispose();
         _highlighter = null;
         super.dispose();
      }
      
      private function get variableListContainer() : class_1812
      {
         return container.findChildByName("variable_list_container") as class_1812;
      }
      
      private function get propertiesTableContainer() : class_1812
      {
         return container.findChildByName("variable_properties_table_container") as class_1812;
      }
      
      private function get textsTableContainer() : class_1812
      {
         return container.findChildByName("variable_texts_table_container") as class_1812;
      }
      
      private function get highlightHoldersButton() : class_1775
      {
         return container.findChildByName("highlight_holders_button") as class_1775;
      }
      
      private function get manageButton() : class_1775
      {
         return container.findChildByName("manage_button") as class_1775;
      }
      
      private function get typePickerContainer() : class_1812
      {
         return container.findChildByName("type_picker_container") as class_1812;
      }
   }
}

