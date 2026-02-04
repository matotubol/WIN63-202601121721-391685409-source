package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class DropMenuController extends DropBaseController implements class_2261
   {
      
      private static const DROP_MENU_ITEM_MAX_LENGTH:int = 200;
      
      private var _stringArray:Array = [];
      
      public function DropMenuController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         _stringArray = null;
         super.dispose();
      }
      
      override public function populate(param1:Array) : void
      {
         var_208 = -1;
         while(_stringArray.length > 0)
         {
            _stringArray.pop();
         }
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _stringArray.push(param1[_loc2_]);
            _loc2_++;
         }
         _menuIsOpen = true;
         closeExpandedMenuView();
      }
      
      public function populateWithVector(param1:Vector.<String>) : void
      {
         var_208 = -1;
         while(_stringArray.length > 0)
         {
            _stringArray.pop();
         }
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _stringArray.push(param1[_loc2_]);
            _loc2_++;
         }
         _menuIsOpen = true;
         closeExpandedMenuView();
      }
      
      override protected function populateExpandedMenu(param1:Vector.<class_1741>, param2:DropBaseController, param3:Function) : void
      {
         var _loc5_:class_2111 = null;
         var _loc12_:String = null;
         if(!param2)
         {
            return;
         }
         var _loc7_:IItemListWindow = param2.getItemList();
         _loc7_.autoArrangeItems = false;
         param2.getRegion().visible = false;
         var _loc10_:uint = _stringArray.length;
         var _loc9_:int;
         var _loc6_:* = _loc9_ = int(_loc7_.width);
         var _loc8_:int = 0;
         var _loc11_:uint = 0;
         while(_loc11_ < _loc10_)
         {
            _loc12_ = _stringArray[_loc11_];
            if(_loc12_.length > 200)
            {
               _loc12_ = _loc12_.substring(0,200) + "...";
            }
            _loc5_ = context.create(name + "::menuItem[" + _loc11_ + "]",_loc12_,103,_style,0 | 0 | 0x10 | 1 | 0,null,param3,null,_loc11_,null,"",["_EXCLUDE"]) as DropMenuItemController;
            _itemArray.push(_loc5_);
            _loc6_ = Math.max(_loc6_,_loc5_.width);
            _loc8_ += _loc5_.height;
            _loc5_.width = _loc9_;
            _loc7_.addListItem(_loc5_);
            _loc11_++;
         }
         if(_loc6_ > _loc9_)
         {
            param2.width += _loc6_ - _loc7_.width;
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               _loc7_.getListItemAt(_loc11_).width = _loc6_;
               _loc11_++;
            }
         }
         var _loc4_:class_1741 = context.create(name + "::padding","",4,_style,0 | 0 | 0x10 | 0,new Rectangle(0,0,1,3),null,null,0,null,"",["_EXCLUDE"]);
         _loc7_.addListItem(_loc4_);
         _loc7_.autoArrangeItems = true;
         _loc8_ += _loc4_.height;
         _loc8_ = _loc8_ + _loc7_.spacing * _loc7_.numListItems;
         param2.height = Math.max(param2.height,_loc8_ + 4);
         fitToDesktop(param2);
         param2.activate();
         _loc7_.height = Math.max(_loc7_.height,param2.height - 4);
         if(var_208 > -1 && _loc10_)
         {
            _loc7_.getListItemAt(var_208).setStateFlag(8,true);
         }
      }
      
      override protected function closeExpandedMenuView() : void
      {
         var _loc2_:class_1758 = null;
         if(close())
         {
            if(var_224 != null)
            {
               var_224.destroy();
               var_224 = null;
            }
            if(_menuIsOpen)
            {
               _loc2_ = class_1758.allocate("WE_COLLAPSE",this,null);
               update(this,_loc2_);
               _loc2_.recycle();
            }
            _menuIsOpen = false;
            while(_itemArray.length > 0)
            {
               _itemArray.pop().dispose();
            }
            if(!disposed)
            {
               var _loc1_:ILabelWindow = getTitleLabel();
               null.visible = true;
            }
         }
      }
      
      public function enumerateSelection() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(!_disposed)
         {
            _loc2_ = 0;
            while(_loc2_ < _stringArray.length)
            {
               _loc1_.push(_stringArray[_loc2_]);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      override public function get numMenuItems() : int
      {
         return _stringArray.length;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("item_array",_stringArray));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("item_array" === _loc3_)
            {
               this.populate(_loc2_.value as Array);
            }
         }
         super.properties = param1;
      }
      
      public function openMenu() : void
      {
         openExpandedMenuView();
      }
   }
}

