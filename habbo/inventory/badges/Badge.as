package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.widgets.class_3087;
   
   public class Badge
   {
      
      public static var var_2639:class_1812;
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var var_265:Boolean = false;
      
      private var var_605:String;
      
      private var var_2983:Boolean;
      
      private var var_2281:Boolean;
      
      private var _window:class_1812;
      
      private var var_978:class_1741;
      
      private var _isUnseen:Boolean;
      
      private var _name:String;
      
      private var _desc:String;
      
      private var var_36:BadgesModel;
      
      public function Badge(param1:BadgesModel, param2:String, param3:String, param4:String, param5:Boolean)
      {
         super();
         var_36 = param1;
         var_605 = param2;
         _name = param3;
         _desc = param4;
         _isUnseen = param5;
         this.isSelected = false;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get badgeId() : String
      {
         return var_605;
      }
      
      public function get badgeName() : String
      {
         return _name;
      }
      
      public function get badgeDescription() : String
      {
         return _desc;
      }
      
      public function get isInUse() : Boolean
      {
         return var_2983;
      }
      
      public function get isSelected() : Boolean
      {
         return var_2281;
      }
      
      public function get window() : class_1812
      {
         if(!var_265)
         {
            initWindow();
         }
         return _window;
      }
      
      private function initWindow() : void
      {
         _window = var_2639.clone() as class_1812;
         class_3087(class_2010(_window.findChildByName("badge")).widget).badgeId = badgeId;
         _window.findChildByName("badge").visible = true;
         var_978 = _window.findChildByTag("BG_COLOR");
         var_265 = true;
         _window.procedure = itemEventProc;
      }
      
      private function itemEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:* = param1.type;
         if("WME_CLICK" === _loc3_)
         {
            var_36.setBadgeSelected(this.badgeId);
         }
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         var_2983 = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         var_2281 = param1;
         if(var_978 == null || _window == null)
         {
            return;
         }
         var_978.color = _isUnseen ? 10275685 : 13421772;
         _window.findChildByName("outline").visible = param1;
      }
      
      public function set isUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            this.isSelected = var_2281;
         }
      }
   }
}

