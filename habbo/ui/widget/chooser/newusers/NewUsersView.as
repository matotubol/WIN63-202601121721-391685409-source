package com.sulake.habbo.ui.widget.chooser.newusers
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
   
   public class NewUsersView
   {
      
      public static var COLUMN_USER_NAME:String = "name";
      
      public static var COLUMN_TYPE:String = "type";
      
      private var var_16:NewUsersChooserWidget;
      
      private var var_839:String;
      
      private var var_647:TableView;
      
      private var _window:class_2250;
      
      private var _ignoreListeners:Boolean;
      
      public function NewUsersView(param1:NewUsersChooserWidget, param2:String)
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
         var _loc1_:XmlAsset = XmlAsset(var_16.assets.getAssetByName("new_user_chooser_view"));
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
         typeDropdown.addEventListener("WE_SELECTED",onTypeChanged);
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
      
      private function onTypeChanged(param1:class_1758) : void
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
         populateWithFilters();
      }
      
      private function populateWithFilters() : void
      {
         var _loc3_:String = searchTextInput.text.toLowerCase();
         var _loc2_:int = typeDropdown.selection;
         if(_loc2_ == 3)
         {
            _loc2_ = 4;
         }
         var _loc1_:Array = [];
         for each(var _loc4_ in var_16.items)
         {
            if(!(_loc3_.length > 0 && _loc4_.lowerCaseName.indexOf(_loc3_) == -1))
            {
               if(!(_loc2_ > 0 && _loc4_.type != _loc2_))
               {
                  _loc1_.push(_loc4_);
               }
            }
         }
         populate(_loc1_);
         amountIndicator.text = var_16.localizations.getLocalizationWithParams("new_user_chooser.amount_indicator","","amount",_loc1_.length);
      }
      
      private function populate(param1:Array) : void
      {
         var _loc2_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc3_ in param1)
         {
            _loc2_.push(new NewUsersChooserTableObject(_loc3_));
         }
         var_647.setObjects(_loc2_);
      }
      
      private function createTable() : void
      {
         var_647 = new TableView(var_16.windowManager,tableViewContainer,true);
         var _loc1_:Array = [new TableColumn(COLUMN_USER_NAME,localize("new_user_chooser.col.name"),0.65,"left"),new TableColumn(COLUMN_TYPE,localize("new_user_chooser.col.type"),0.35,"left")];
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
      
      private function onListItemClicked(param1:NewUsersChooserTableObject) : void
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
      
      private function get typeDropdown() : class_2261
      {
         return _window.findChildByName("type_dropdown") as class_2261;
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

