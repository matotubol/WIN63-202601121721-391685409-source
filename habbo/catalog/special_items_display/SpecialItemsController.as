package com.sulake.habbo.catalog.special_items_display
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.special_items_display.model.FurniSpecialItem;
   import com.sulake.habbo.catalog.special_items_display.model.class_2451;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class SpecialItemsController extends class_17 implements ILinkEventTracker, ISpecialItemsDisplay
   {
      
      public static const ITEM_TYPE_FURNI:String = "furni";
      
      private var _catalog:HabboCatalog;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:class_38;
      
      private var _roomEngine:IRoomEngine;
      
      private var _key:String;
      
      private var _items:Vector.<class_2451>;
      
      private var var_18:SpecialItemsView;
      
      public function SpecialItemsController(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1 as HabboCatalog;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "special_items_display/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         _key = _loc2_[1];
         if(parseSpecialItems())
         {
            openView();
         }
      }
      
      private function parseSpecialItems() : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         var _loc5_:class_2451 = null;
         var _loc7_:Vector.<class_2451> = new Vector.<class_2451>();
         var _loc8_:String = getProperty("special_items." + _key + ".items");
         var _loc6_:int = 0;
         var _loc10_:Array = _loc8_.split(";");
         for each(var _loc1_ in _loc10_)
         {
            _loc2_ = _loc1_.split(",",3);
            _loc3_ = _loc2_[0];
            _loc9_ = _loc2_[1];
            _loc4_ = _loc2_[2];
            _loc5_ = null;
            var _loc11_:String = _loc9_;
            if("furni" === _loc11_)
            {
               _loc5_ = new FurniSpecialItem(_loc6_,_key,_loc3_,this,_loc4_);
            }
            if(_loc5_ != null && _loc5_.isValid)
            {
               _loc7_.push(_loc5_);
               _loc6_ += 1;
            }
         }
         _items = _loc7_;
         return _loc7_.length > 0;
      }
      
      private function openView() : void
      {
         if(var_18 == null)
         {
            var_18 = new SpecialItemsView(this,_windowManager);
         }
         var_18.displayNewData();
         if(!var_18.isShowing())
         {
            var_18.show();
         }
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get items() : Vector.<class_2451>
      {
         return _items;
      }
      
      public function get view() : SpecialItemsView
      {
         return var_18;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         _catalog = null;
         _sessionDataManager = null;
         _windowManager = null;
         _localizationManager = null;
         _roomEngine = null;
         super.dispose();
      }
   }
}

