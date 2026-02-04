package com.sulake.habbo.ui.widget.chooser.newfurni
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.Dictionary;
   
   public class NewFurniView
   {
      
      public static var COLUMN_FURNI_NAME:String = "name";
      
      public static var COLUMN_FURNI_OWNER:String = "owner";
      
      public static var COLUMN_ID:String = "id";
      
      private var var_16:NewFurniChooserWidget;
      
      private var var_839:String;
      
      private var var_647:TableView;
      
      private var _window:class_2250;
      
      private var _ignoreListeners:Boolean;
      
      public function NewFurniView(param1:NewFurniChooserWidget, param2:String)
      {
         super();
         var_16 = param1;
         var_839 = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = XmlAsset(var_16.assets.getAssetByName("new_furni_chooser_view"));
         if(_loc1_ == null)
         {
            return;
         }
         _window = var_16.windowManager.buildFromXML(_loc1_.content as XML) as class_2250;
         if(_window == null)
         {
            return;
         }
         _window.caption = var_839;
         createTable();
         closeButton.addEventListener("WME_CLICK",onClose);
         searchTextInput.addEventListener("WE_CHANGE",onSearchChanged);
         usernameDropDown.addEventListener("WE_SELECTED",onUsernameChanged);
         clearButton.addEventListener("WME_CLICK",onClearClicked);
         if(_window.parent != null)
         {
            _window.x = _window.parent.width - _window.width - 10;
            _window.y = 10;
         }
      }
      
      private function onClearClicked(param1:WindowMouseEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         searchTextInput.text = "";
         onSearchChanged(null);
      }
      
      private function onUsernameChanged(param1:class_1758) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         populateWithFilters();
      }
      
      private function onSearchChanged(param1:class_1758) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         var _loc2_:String = searchTextInput.text;
         clearButton.visible = _loc2_.length > 0;
         textPlaceholder.visible = _loc2_.length == 0;
         populateWithFilters();
      }
      
      public function onItemsChanged() : void
      {
         if(var_16 == null)
         {
            return;
         }
         if(_window == null)
         {
            createWindow();
         }
         constructOwners();
         populateWithFilters();
      }
      
      private function populateWithFilters() : void
      {
         var _loc1_:Array = searchTextInput.text.toLowerCase().split(" ");
         var _loc6_:int = usernameDropDown.selection;
         var _loc2_:String = _loc6_ > 0 ? usernameDropDown.enumerateSelection()[_loc6_] : null;
         var _loc3_:Array = [];
         loop0:
         for each(var _loc4_ in var_16.items)
         {
            for each(var _loc5_ in _loc1_)
            {
               if(_loc4_.lowerCaseName.indexOf(_loc5_) != -1)
               {
                  continue;
               }
               continue loop0;
            }
            if(!(_loc2_ != null && _loc4_.owner != _loc2_))
            {
               _loc3_.push(_loc4_);
            }
         }
         populate(_loc3_);
         amountIndicator.text = var_16.localizations.getLocalizationWithParams("new_furni_chooser.amount_indicator","","amount",_loc3_.length);
      }
      
      public function constructOwners() : void
      {
         _ignoreListeners = true;
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:Array = [];
         _loc2_.push(localize("new_furni_chooser.owner_selector.default"));
         for each(var _loc3_ in var_16.items)
         {
            if(!(_loc3_.owner in _loc1_))
            {
               _loc2_.push(_loc3_.owner);
               _loc1_[_loc3_.owner] = true;
            }
         }
         if(usernameDropDown.numMenuItems != _loc2_.length || usernameDropDown.numMenuItems == 1 && usernameDropDown.enumerateSelection()[0] == "")
         {
            usernameDropDown.populate(_loc2_);
            usernameDropDown.selection = 0;
            if(_loc2_.length <= 2)
            {
               usernameDropDown.disable();
               usernameDropDown.blend = 0.5;
            }
            else
            {
               usernameDropDown.enable();
               usernameDropDown.blend = 1;
            }
         }
         _ignoreListeners = false;
      }
      
      private function populate(param1:Array) : void
      {
         var _loc2_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc3_ in param1)
         {
            _loc2_.push(new NewFurniChooserTableObject(_loc3_));
         }
         var_647.setObjects(_loc2_);
      }
      
      private function createTable() : void
      {
         var_647 = new TableView(var_16.windowManager,tableViewContainer,true);
         var _loc1_:Array = [new TableColumn(COLUMN_FURNI_NAME,localize("new_furni_chooser.col.name"),0.5,"left"),new TableColumn(COLUMN_FURNI_OWNER,localize("new_furni_chooser.col.owner"),0.25,"left"),new TableColumn(COLUMN_ID,localize("new_furni_chooser.col.id"),0.25,"left")];
         var_647.initialize(Vector.<TableColumn>(_loc1_),true,true);
         var_647.onRowClickedCallback = onListItemClicked;
      }
      
      private function hideWindow() : void
      {
         if(_window != null)
         {
            var_647.dispose();
            var_647 = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function onListItemClicked(param1:NewFurniChooserTableObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ChooserItem = param1.chooserItem;
         if(_loc2_ == null)
         {
            return;
         }
         var_16.choose(_loc2_.id,_loc2_.category);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hideWindow();
      }
      
      public function localize(param1:String) : String
      {
         return var_16.localizations.getLocalization(param1,param1);
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByTag("close");
      }
      
      private function get tableViewContainer() : class_1812
      {
         return _window.findChildByName("table_container") as class_1812;
      }
      
      private function get textPlaceholder() : ITextWindow
      {
         return _window.findChildByName("search_placeholder") as ITextWindow;
      }
      
      private function get searchTextInput() : ITextFieldWindow
      {
         return _window.findChildByName("text_input") as ITextFieldWindow;
      }
      
      private function get usernameDropDown() : class_2261
      {
         return _window.findChildByName("username_dropdown") as class_2261;
      }
      
      private function get clearButton() : class_1812
      {
         return _window.findChildByName("clear_button") as class_1812;
      }
      
      private function get amountIndicator() : ITextWindow
      {
         return _window.findChildByName("amount_indicator") as ITextWindow;
      }
   }
}

