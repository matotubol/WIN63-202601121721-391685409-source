package com.sulake.habbo.catalog.navigation
{
   import package_10.class_2971;
   
   public class CatalogNode implements class_1917
   {
      
      private static const ICON_PREFIX:String = "icon_";
      
      private var _depth:int = 0;
      
      private var _localization:String = "";
      
      private var var_2228:int = -1;
      
      private var _pageName:String = "";
      
      private var var_3703:int = 0;
      
      private var _children:Vector.<class_1917>;
      
      private var _offerIds:Vector.<int>;
      
      private var _navigator:class_1737;
      
      private var _parent:class_1917;
      
      public function CatalogNode(param1:class_1737, param2:class_2971, param3:int, param4:class_1917)
      {
         super();
         _depth = param3;
         _parent = param4;
         _navigator = param1;
         _localization = param2.localization;
         var_2228 = param2.pageId;
         _pageName = param2.pageName;
         var_3703 = param2.icon;
         _children = new Vector.<class_1917>(0);
         _offerIds = param2.offerIds;
      }
      
      public function get isOpen() : Boolean
      {
         return false;
      }
      
      public function get depth() : int
      {
         return _depth;
      }
      
      public function get isBranch() : Boolean
      {
         return _children.length > 0;
      }
      
      public function get isLeaf() : Boolean
      {
         return _children.length == 0;
      }
      
      public function get visible() : Boolean
      {
         return false;
      }
      
      public function get localization() : String
      {
         return _localization;
      }
      
      public function get pageId() : int
      {
         return var_2228;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get children() : Vector.<class_1917>
      {
         return _children;
      }
      
      public function get offerIds() : Vector.<int>
      {
         return _offerIds;
      }
      
      public function get navigator() : class_1737
      {
         return _navigator;
      }
      
      public function get parent() : class_1917
      {
         return _parent;
      }
      
      public function set parent(param1:class_1917) : void
      {
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _children)
         {
            _loc1_.dispose();
         }
         _children = null;
         _offerIds = null;
         _navigator = null;
         _parent = null;
         _pageName = "";
         _localization = "";
      }
      
      public function addChild(param1:class_1917) : void
      {
         if(param1 == null)
         {
            return;
         }
         _children.push(param1);
      }
      
      public function activate() : void
      {
      }
      
      public function deactivate() : void
      {
      }
      
      public function open() : void
      {
      }
      
      public function close() : void
      {
      }
      
      public function get iconName() : String
      {
         if(var_3703 < 1)
         {
            return "";
         }
         return "icon_" + var_3703.toString();
      }
      
      public function get offsetV() : int
      {
         return 0;
      }
   }
}

