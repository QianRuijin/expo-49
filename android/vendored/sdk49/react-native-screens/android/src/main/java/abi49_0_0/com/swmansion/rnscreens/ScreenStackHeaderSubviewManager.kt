package abi49_0_0.com.swmansion.rnscreens

import abi49_0_0.com.facebook.react.bridge.JSApplicationIllegalArgumentException
import abi49_0_0.com.facebook.react.module.annotations.ReactModule
import abi49_0_0.com.facebook.react.uimanager.ThemedReactContext
import abi49_0_0.com.facebook.react.uimanager.ViewGroupManager
import abi49_0_0.com.facebook.react.uimanager.ViewManagerDelegate
import abi49_0_0.com.facebook.react.uimanager.annotations.ReactProp
import abi49_0_0.com.facebook.react.viewmanagers.RNSScreenStackHeaderSubviewManagerDelegate
import abi49_0_0.com.facebook.react.viewmanagers.RNSScreenStackHeaderSubviewManagerInterface

@ReactModule(name = ScreenStackHeaderSubviewManager.REACT_CLASS)
class ScreenStackHeaderSubviewManager : ViewGroupManager<ScreenStackHeaderSubview>(), RNSScreenStackHeaderSubviewManagerInterface<ScreenStackHeaderSubview> {
    private val mDelegate: ViewManagerDelegate<ScreenStackHeaderSubview>

    init {
        mDelegate = RNSScreenStackHeaderSubviewManagerDelegate<ScreenStackHeaderSubview, ScreenStackHeaderSubviewManager>(this)
    }

    override fun getName() = REACT_CLASS

    override fun createViewInstance(context: ThemedReactContext) = ScreenStackHeaderSubview(context)

    @ReactProp(name = "type")
    override fun setType(view: ScreenStackHeaderSubview, type: String?) {
        view.type = when (type) {
            "left" -> ScreenStackHeaderSubview.Type.LEFT
            "center" -> ScreenStackHeaderSubview.Type.CENTER
            "right" -> ScreenStackHeaderSubview.Type.RIGHT
            "back" -> ScreenStackHeaderSubview.Type.BACK
            "searchBar" -> ScreenStackHeaderSubview.Type.SEARCH_BAR
            else -> throw JSApplicationIllegalArgumentException("Unknown type $type")
        }
    }

    protected override fun getDelegate(): ViewManagerDelegate<ScreenStackHeaderSubview> = mDelegate

    companion object {
        const val REACT_CLASS = "RNSScreenStackHeaderSubview"
    }
}
