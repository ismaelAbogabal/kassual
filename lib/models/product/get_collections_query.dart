String getAllCollectionQuery = r'''
{
  collections(first: 13) {
    pageInfo{
      hasNextPage
    }
      edges {
        cursor
        node {
          title
          description
          descriptionHtml
          handle
          id
          updatedAt
          image {
            altText
            id
            originalSrc
          }
          products(first:13) {
            edges {
              node {
                variants(first: 1) {
                  edges {
                    node {
                      id
                      title
                      image {
                        id
                        altText
                        originalSrc
                      }
                      priceV2 {
                        amount
                        currencyCode
                      }
                      compareAtPriceV2 {
                        amount
                        currencyCode
                      }
                      weight
                      weightUnit
                      sku
                      requiresShipping
                      availableForSale
                    }
                  }
                }
                availableForSale
                createdAt
                description
                descriptionHtml
                handle
                id
                images(first: 10) {
                  edges {
                    node {
                      altText
                      id
                      originalSrc
                    }
                  }
                }
                onlineStoreUrl
                productType
                publishedAt
                tags
                title
                updatedAt
                vendor
              }
              cursor
            }
            pageInfo {
              hasNextPage
            }
          }
        }
      }
    }
  }
''';
