import { installAsync } from '../../install/installAsync';
import { copyAsync } from '../../utils/dir';
import { queryAndGenerateAsync, selectAndGenerateAsync } from '../generate';
import { selectTemplatesAsync } from '../templates';

const asMock = <T extends (...args: any[]) => any>(fn: T): jest.MockedFunction<T> =>
  fn as jest.MockedFunction<T>;

jest.mock('../../log');
jest.mock('../templates', () => {
  const templates = jest.requireActual('../templates');
  return {
    ...templates,
    selectTemplatesAsync: jest.fn(),
  };
});
jest.mock('../../install/installAsync', () => ({ installAsync: jest.fn() }));
jest.mock('../../utils/dir', () => ({ copyAsync: jest.fn() }));

describe(queryAndGenerateAsync, () => {
  it(`asserts an invalid file`, async () => {
    await expect(
      queryAndGenerateAsync('/', {
        files: ['file1', 'file2'],
        props: {
          webStaticPath: 'web',
        },
        extras: [],
      })
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `"Invalid files: file1, file2. Allowed: babel.config.js, webpack.config.js, metro.config.js, web/serve.json, web/index.html"`
    );
  });
  it(`does nothing`, async () => {
    await queryAndGenerateAsync('/', {
      files: [],
      props: {
        webStaticPath: 'web',
      },
      extras: ['foobar'],
    });
    expect(copyAsync).not.toBeCalled();
    expect(installAsync).not.toBeCalled();
  });
  it(`queries a file, generates, and installs`, async () => {
    await queryAndGenerateAsync('/', {
      files: ['babel.config.js'],
      props: {
        webStaticPath: 'web',
      },
      extras: ['foobar'],
    });
    expect(copyAsync).toBeCalledWith(
      expect.stringMatching(/@expo\/cli\/static\/template\/babel\.config\.js/),
      '/babel.config.js',
      { overwrite: true, recursive: true }
    );
    expect(installAsync).toBeCalledWith(['babel-preset-expo'], {}, ['--dev', 'foobar']);
  });
});

describe(selectAndGenerateAsync, () => {
  it(`exits when no items are selected`, async () => {
    asMock(selectTemplatesAsync).mockResolvedValue([]);

    await expect(
      selectAndGenerateAsync('/', {
        props: {
          webStaticPath: 'web',
        },
        extras: [],
      })
    ).rejects.toThrow(/EXIT/);

    expect(copyAsync).not.toBeCalled();
    expect(installAsync).not.toBeCalled();
  });

  it(`selects a file, generates, and installs`, async () => {
    asMock(selectTemplatesAsync).mockResolvedValue([1]);

    await selectAndGenerateAsync('/', {
      props: {
        webStaticPath: 'web',
      },
      extras: [],
    });
    expect(copyAsync).toBeCalledWith(
      expect.stringMatching(/@expo\/webpack-config\/template\/webpack\.config\.js/),
      '/webpack.config.js',
      { overwrite: true, recursive: true }
    );
    expect(installAsync).toBeCalledWith(['@expo/webpack-config'], {}, ['--dev']);
  });
});