package com.sulake.habbo.roomevents.wired_menu.variables_management.detail
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2872;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection.VariableValueTableObject;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import com.sulake.habbo.utils.LoadingIcon;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import package_117.WiredSetUserPermanentVariableComposer;
   import package_117.WiredGetUserPermanentVariablesComposer;
   import package_188.VariableList;
   import package_189.WiredVariable;
   import package_201.WiredUserPermanentVariablesList;
   import package_201.WiredVariableStorageParameter;
   
   public class VariableManagementDetailView implements class_13
   {
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      public static var VARIABLES_COLUMN_VARIABLE:String = "variable";
      
      public static var VARIABLES_COLUMN_VALUE:String = "value";
      
      private var _disposed:Boolean = false;
      
      private var var_55:VariableManagementDetailController;
      
      private var _windowManager:class_38;
      
      private var _loadingIcon:LoadingIcon;
      
      private var _window:class_2250;
      
      private var var_468:TableView;
      
      private var var_1278:NewVariablePicker;
      
      private var var_994:PermanentVariableHolderPreviewer;
      
      public function VariableManagementDetailView(param1:VariableManagementDetailController, param2:class_38)
      {
         super();
         var_55 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(var_55.assets.getAssetByName("variables_management_detail_xml").content),1) as class_2250;
         _loadingIcon = new LoadingIcon();
         var_468 = new TableView(param2,variableValuesTableContainer);
         var_994 = new PermanentVariableHolderPreviewer(previewWindow,var_55.roomEvents.wiredMenu);
         createVariableValuesTable();
         createCreateVariableBubble();
         refreshButton.addEventListener("WME_CLICK",onRefreshClick);
         closeButton.addEventListener("WME_CLICK",onClose);
         deleteVariableButton.addEventListener("WME_CLICK",onDeleteVariableClicked);
         addVariableButton.addEventListener("WME_CLICK",onAddVariableClicked);
         createVariableButton.addEventListener("WME_CLICK",onCreateVariableClicked);
         _window.procedure = windowProcedure;
         hide();
      }
      
      private function onRefreshClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:WiredUserPermanentVariablesList = var_55.data;
         var_55.send(new WiredGetUserPermanentVariablesComposer(_loc2_.entityType,_loc2_.entityId));
         _loadingIcon.setVisible(loadingIconWindow,true);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         var _loc1_:class_2052 = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function show() : void
      {
         var _loc1_:class_2052 = null;
         if(!isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
               _window.center();
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _window.parent != null;
      }
      
      private function createVariableValuesTable() : void
      {
         var _loc1_:Array = [new TableColumn(VARIABLES_COLUMN_VARIABLE,var_55.localizationManager.getLocalization("wiredmenu.inspection.variables.variable"),0.65,"left"),new TableColumn(VARIABLES_COLUMN_VALUE,var_55.localizationManager.getLocalization("wiredmenu.inspection.variables.value"),0.35,"right")];
         var_468.initialize(Vector.<TableColumn>(_loc1_));
         var_468.onCellEditCallback = onCellEdit;
         var_468.onRowSelectedCallback = onRowSelected;
      }
      
      private function createCreateVariableBubble() : void
      {
         var _loc1_:HabboUserDefinedRoomEvents = var_55.roomEvents;
         var _loc3_:PresetManager = _loc1_.wiredCtrl.presetManager;
         var _loc2_:class_1812 = _loc3_.createLayout("search_tree_dropdown") as class_1812;
         variablePickerContainer.addChild(_loc2_);
         var_1278 = new NewVariablePicker(var_55.roomEvents,_loc2_,variableFilter,onChangeCreateVariable);
         var_1278.width = variablePickerContainer.width;
         createVariableBubble.visible = false;
      }
      
      private function onChangeCreateVariable(param1:WiredVariable) : void
      {
         Util.disableSection(valueSettingContainer,param1 != null && !param1.hasValue);
         Util.disableSection(createVariableButton,param1 == null);
      }
      
      private function variableFilter(param1:WiredVariable) : Boolean
      {
         var _loc2_:WiredUserPermanentVariablesList = var_55.data;
         return param1.canCreateAndDelete && (_loc2_ == null || !(param1.variableId in _loc2_.variableIds)) && param1.isPersisted;
      }
      
      private function onCellEdit(param1:ITableObject, param2:String, param3:String) : void
      {
         if(param2 != VARIABLES_COLUMN_VALUE)
         {
            return;
         }
         var _loc6_:VariableValueTableObject = param1 as VariableValueTableObject;
         var _loc5_:WiredVariable = _loc6_.variable;
         if(!hasWritePermission || !_loc5_.hasValue || !_loc5_.canWriteValue)
         {
            return;
         }
         var _loc4_:WiredUserPermanentVariablesList = var_55.data;
         var _loc7_:int = Util.getIntFromString(param3,-2147483648,true);
         if(_loc7_ != -2147483648)
         {
            var_55.send(new WiredSetUserPermanentVariableComposer(_loc4_.entityType,_loc4_.entityId,_loc5_.variableId,_loc7_,0));
            _loadingIcon.setVisible(loadingIconWindow,true);
         }
      }
      
      private function get hasWritePermission() : Boolean
      {
         return var_55.roomEvents.wiredMenu.hasWritePermission;
      }
      
      private function onAddVariableClicked(param1:WindowMouseEvent) : void
      {
         if(createVariableBubble.visible)
         {
            createVariableBubble.visible = false;
         }
         else
         {
            var_55.roomEvents.variablesSynchronizer.getAllVariables(initializeCreateVariableBubble,true);
         }
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && Boolean(createVariableBubble.visible))
         {
            if(param2.name != "add_var_btn" && !createVariableBubble.windowIsChild(param2))
            {
               createVariableBubble.visible = false;
            }
         }
      }
      
      private function initializeCreateVariableBubble(param1:Vector.<WiredVariable>) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_);
         }
         var_1278.init(new VariableList(_loc3_),"",WiredInputSourcePicker.USER_SOURCE);
         Util.disableSection(createVariableButton,true);
         createVariableBubble.visible = true;
      }
      
      private function onDeleteVariableClicked(param1:WindowMouseEvent) : void
      {
         if(var_55.data == null)
         {
            return;
         }
         var _loc4_:VariableValueTableObject = var_468.selected as VariableValueTableObject;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:WiredVariable = _loc4_.variable;
         if(!hasWritePermission || !_loc3_.canCreateAndDelete)
         {
            return;
         }
         var _loc2_:WiredUserPermanentVariablesList = var_55.data;
         var_55.send(new WiredSetUserPermanentVariableComposer(_loc2_.entityType,_loc2_.entityId,_loc3_.variableId,0,2));
         _loadingIcon.setVisible(loadingIconWindow,true);
      }
      
      private function onCreateVariableClicked(param1:WindowMouseEvent) : void
      {
         if(var_55.data == null)
         {
            return;
         }
         var _loc3_:WiredVariable = var_1278.selected;
         var_1278.finalize();
         var _loc4_:int = 0;
         if(_loc3_.hasValue)
         {
            _loc4_ = int(valueInput.text);
         }
         var _loc2_:WiredUserPermanentVariablesList = var_55.data;
         var_55.send(new WiredSetUserPermanentVariableComposer(_loc2_.entityType,_loc2_.entityId,_loc3_.variableId,_loc4_,1));
         _loadingIcon.setVisible(loadingIconWindow,true);
         createVariableBubble.visible = false;
         valueInput.text = "0";
      }
      
      private function onRowSelected(param1:VariableValueTableObject) : void
      {
         updateButtonsUI();
      }
      
      private function updateButtonsUI() : void
      {
         var _loc3_:VariableValueTableObject = null;
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(hasWritePermission)
         {
            _loc3_ = var_468.selected as VariableValueTableObject;
            if(_loc3_ != null && _loc3_.variable != null && _loc3_.variable.canCreateAndDelete)
            {
               _loc2_ = true;
            }
            _loc1_ = true;
         }
         Util.disableSection(deleteVariableButton,!_loc2_);
         Util.disableSection(addVariableButton,!_loc1_);
      }
      
      public function displayNewData() : void
      {
         var _loc1_:WiredUserPermanentVariablesList = var_55.data;
         if(_loc1_ == null)
         {
            return;
         }
         updateTableviewUI();
         updatePreviewUI();
         updateInfoBoxUI();
         updateButtonsUI();
         _loadingIcon.setVisible(loadingIconWindow,false);
         var_468.scrollToTop();
         _window.activate();
      }
      
      private function updatePreviewUI() : void
      {
         var _loc2_:int = 0;
         var _loc1_:WiredUserPermanentVariablesList = var_55.data;
         if(_loc1_ == null)
         {
            var_994.clearPreviewer();
            return;
         }
         if(_loc1_.entityType == 2)
         {
            var_994.setPetPreview(_loc1_.entityFigure);
         }
         else
         {
            _loc2_ = _loc1_.entityId;
            var_994.setUserPreview(_loc1_.entityFigure,_loc2_);
         }
      }
      
      private function updateInfoBoxUI() : void
      {
         var _loc1_:WiredUserPermanentVariablesList = var_55.data;
         if(_loc1_ == null)
         {
            infoBoxText.text = "";
            return;
         }
         if(_loc1_.entityType == 1)
         {
            infoBoxText.text = var_55.localizationManager.getLocalizationWithParams("wiredmenu.variable_management_detail.info.user","","name",_loc1_.entityName,"id",_loc1_.entityId);
         }
         else if(_loc1_.entityType == 2)
         {
            infoBoxText.text = var_55.localizationManager.getLocalizationWithParams("wiredmenu.variable_management_detail.info.pet","","name",_loc1_.entityName,"id",_loc1_.entityId,"owner_name",_loc1_.ownerName,"owner_id",_loc1_.ownerId);
         }
         else if(_loc1_.entityType == 4)
         {
            infoBoxText.text = var_55.localizationManager.getLocalizationWithParams("wiredmenu.variable_management_detail.info.bot","","name",_loc1_.entityName,"id",_loc1_.entityId,"owner_name",_loc1_.ownerName,"owner_id",_loc1_.ownerId);
         }
      }
      
      public function updateTableviewUI() : void
      {
         var _loc6_:WiredVariable = null;
         var _loc5_:Boolean = false;
         var _loc4_:WiredUserPermanentVariablesList = var_55.data;
         var _loc2_:Array = [];
         var _loc1_:class_55 = new class_55();
         for each(var _loc7_ in _loc4_.variableStorage)
         {
            _loc6_ = var_55.variablesById[_loc7_.variableId];
            if(_loc6_ != null)
            {
               _loc2_.push(_loc6_);
               _loc1_.add(_loc6_.variableId,_loc7_.value);
            }
         }
         Util.sortVariables(_loc2_);
         var _loc3_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(_loc6_ in _loc2_)
         {
            if(!_loc6_.isInvisible)
            {
               _loc5_ = hasWritePermission && _loc6_.hasValue && _loc6_.canWriteValue;
               _loc3_.push(new VariableValueTableObject(_loc6_,_loc1_.getValue(_loc6_.variableId),_loc5_,false,var_55.roomEvents));
            }
         }
         var_468.setObjects(_loc3_);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_1278.dispose();
         var_1278 = null;
         _loadingIcon.dispose();
         _loadingIcon = null;
         var_468.dispose();
         var_468 = null;
         _window.dispose();
         _window = null;
         var_55 = null;
         _windowManager = null;
         var_994.dispose();
         var_994 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get refreshButton() : class_1775
      {
         return _window.findChildByName("refresh_btn") as class_1775;
      }
      
      private function get loadingIconWindow() : IIconWindow
      {
         return _window.findChildByName("searching_icon") as IIconWindow;
      }
      
      private function get previewWindow() : class_1812
      {
         return _window.findChildByName("info_box") as class_1812;
      }
      
      private function get infoBoxText() : ITextFieldWindow
      {
         return _window.findChildByName("info_box_text") as ITextFieldWindow;
      }
      
      private function get variableValuesTableContainer() : class_1812
      {
         return _window.findChildByName("variable_values_table_container") as class_1812;
      }
      
      private function get deleteVariableButton() : class_1775
      {
         return _window.findChildByName("delete_var_btn") as class_1775;
      }
      
      private function get addVariableButton() : class_1775
      {
         return _window.findChildByName("add_var_btn") as class_1775;
      }
      
      private function get createVariableBubble() : class_2872
      {
         return _window.findChildByName("create_var_bubble") as class_2872;
      }
      
      private function get variablePickerContainer() : class_1812
      {
         return createVariableBubble.findChildByName("var_picker_container") as class_1812;
      }
      
      private function get valueInputBorder() : class_1993
      {
         return createVariableBubble.findChildByName("value_input_border") as class_1993;
      }
      
      private function get valueInput() : ITextWindow
      {
         return createVariableBubble.findChildByName("value_input") as ITextWindow;
      }
      
      private function get createVariableButton() : class_1775
      {
         return createVariableBubble.findChildByName("create_var_btn") as class_1775;
      }
      
      private function get valueSettingContainer() : class_1812
      {
         return createVariableBubble.findChildByName("value_setting") as class_1812;
      }
   }
}

