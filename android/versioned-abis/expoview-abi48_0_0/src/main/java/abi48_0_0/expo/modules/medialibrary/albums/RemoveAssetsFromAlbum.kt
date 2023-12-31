package abi48_0_0.expo.modules.medialibrary.albums

import android.content.Context
import android.provider.MediaStore.Images.Media
import abi48_0_0.expo.modules.kotlin.Promise
import abi48_0_0.expo.modules.medialibrary.MediaLibraryUtils

internal class RemoveAssetsFromAlbum(
  private val context: Context,
  private val assetIds: Array<String>,
  private val albumId: String,
  private val promise: Promise
) {
  fun execute() {
    val bucketSelection = "${Media.BUCKET_ID}=? AND ${Media._ID} IN (${assetIds.joinToString(",")} )"
    val bucketId = arrayOf(albumId)

    MediaLibraryUtils.deleteAssets(context, bucketSelection, bucketId, promise)
  }
}
